class FirstDate < ActiveRecord::Base
  has_many :first_date_prefs
  has_many :users, through: :first_date_prefs
end
