class User < ActiveRecord::Base
  has_one :deet
  has_one :preference
  has_many :lifestyles, through: :user_lifestyle_prefs
end
