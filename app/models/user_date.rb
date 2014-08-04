class UserDate < ActiveRecord::Base
  belongs_to :date_deets
  belongs_to :user
end
