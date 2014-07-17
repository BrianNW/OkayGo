class Lifestyle < ActiveRecord::Base
  has_many :user_lifestyle_prefs
  has_many :users, through: :user_lifestyle_prefs
end
