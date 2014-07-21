class AddAddressToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :address, :string
    add_column :preferences, :latitude, :float
    add_column :preferences, :longitude, :float
  end
end
