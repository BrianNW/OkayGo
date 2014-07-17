class RemoveLifestylePrefFromPreferences < ActiveRecord::Migration
  def change
    remove_column :preferences, :lifestyle_pref
  end
end
