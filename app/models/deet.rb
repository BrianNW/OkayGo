class Deet < ActiveRecord::Base
  belongs_to :user
  # accepts_nested_attributes_for :lifestyles
  mount_uploader :img, ImgUploader
end
