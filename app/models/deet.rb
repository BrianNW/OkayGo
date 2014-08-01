class Deet < ActiveRecord::Base
  belongs_to :user
  # accepts_nested_attributes_for :lifestyles
end
