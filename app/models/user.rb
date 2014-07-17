class User < ActiveRecord::Base
  has_one :deet
  has_one :preference
end
