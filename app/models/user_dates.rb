class UserDates < ActiveRecord::Base
  belongs_to :user
  belongs_to :date_deet
end
