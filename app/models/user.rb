class User < ActiveRecord::Base
  has_one :deet
  has_one :preference
  has_many :lifestyle_prefs
  has_many :first_date_prefs
  has_many :lifestyles, through: :lifestyle_prefs
  has_many :first_dates, through: :first_date_prefs

  # has_secure_password

  has_and_belongs_to_many :likes

  

end
