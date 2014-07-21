class FirstDatePref < ActiveRecord::Base
  belongs_to :first_date
  belongs_to :user
end
