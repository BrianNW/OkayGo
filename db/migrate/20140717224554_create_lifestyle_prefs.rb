class CreateLifestylePrefs < ActiveRecord::Migration
  def change
    create_table :lifestyle_prefs do |t|
      t.integer :user_id
      t.integer :lifestyle_id

      t.timestamps
    end
  end
end
