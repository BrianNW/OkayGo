class Like < ActiveRecord::Base
  has_many :users
  has_one :first_date
end
