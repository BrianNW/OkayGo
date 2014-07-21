class Preference < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :lifestyles
  accepts_nested_attributes_for :first_dates
end
