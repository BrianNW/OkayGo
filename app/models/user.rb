class User < ActiveRecord::Base
  has_one :preference
end
