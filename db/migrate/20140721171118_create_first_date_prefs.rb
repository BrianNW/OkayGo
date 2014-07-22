class CreateFirstDatePrefs < ActiveRecord::Migration
  def change
    create_table :first_date_prefs do |t|
      t.integer :user_id
      t.integer :first_date_id
      t.timestamps
    end
  end
end
