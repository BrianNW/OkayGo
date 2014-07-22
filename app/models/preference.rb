class Preference < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode
  accepts_nested_attributes_for :lifestyle
  accepts_nested_attributes_for :first_date_prefs
end
