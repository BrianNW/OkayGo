class Preference < ActiveRecord::Base
  belongs_to :user
  # accepts_nested_attributes_for :lifestyle
  # accepts_nested_attributes_for :first_date_prefs
end
