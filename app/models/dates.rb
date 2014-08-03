class Dates < ActiveRecord::Base
  has_many :user_dates
  has_many :users, through: :user_dates
end
