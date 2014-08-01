class User < ActiveRecord::Base

  

  has_one :deet
  has_one :preference
  has_many :lifestyle_prefs
  has_many :first_date_prefs
  has_many :lifestyles, through: :lifestyle_prefs
  has_many :first_dates, through: :first_date_prefs
  has_many :likes, :class_name => 'Like', :foreign_key => 'user_id'
  has_many :liked_by, :class_name => 'Like', :foreign_key => 'target_id'
  has_many :flags, :class_name => 'Flag', :foreign_key => 'user_id'
  has_many :flagged_by, :class_name => 'Flag', :foreign_key => 'target_id'
  has_many :images

  accepts_nested_attributes_for :deet, :preference

  has_secure_password

  # validates_uniqueness_of :username
  # def self.authenticate(user, password)
  #   find_by_username(username).try(:authenticate, password)

    def user_params
      params.require(:user)
        .permit(:username, :password, :password_confirmation)
    end

end
