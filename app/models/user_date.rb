class UserDate < ActiveRecord::Base
  belongs_to :date_deet
  belongs_to :user
end
