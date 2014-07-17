class UserLifestylePref < ActiveRecord::Base
  belongs_to :lifestyle
  belongs_to :user
end
