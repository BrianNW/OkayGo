class UserDate < ActiveRecord::Base
  belongs_to :date_info
  belongs_to :user
end
