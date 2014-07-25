class User < ActiveRecord::Base
  has_one :deet
  has_one :preference
  has_many :lifestyle_prefs
  has_many :first_date_prefs
  has_many :lifestyles, through: :lifestyle_prefs
  has_many :first_dates, through: :first_date_prefs
  has_many :likes, :class_name => 'Like', :foreign_key => 'user_id'
  has_many :liked_by, :class_name => 'Like', :foreign_key => 'target_id'

  # has_secure_password
end
