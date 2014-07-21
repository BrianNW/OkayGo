class User < ActiveRecord::Base
  has_one :deet
  has_one :preference
  has_many :lifestyles, through: :lifestyle_prefs
  has_many :first_dates, through: :date_type_prefs

  # has_secure_password
end
