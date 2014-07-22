class RemoveFirstDatePrefFromPreferences < ActiveRecord::Migration
  def change
    remove_column :preferences, :date_type_pref
  end
end
