class Lifestyle < ActiveRecord::Base
  has_many :lifestyle_prefs
  has_many :users, through: :lifestyle_prefs
end
