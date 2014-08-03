class AddMidpointToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :longitude, :float
    add_column :likes, :latitude, :float
  end
end
