class DateDeets < ActiveRecord::Base
  has_many :user_dates, dependent: :destroy
  has_many :users, through: :user_dates
end
