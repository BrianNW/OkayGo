class Preference < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode
end
