class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user, index: true
      t.string :gender_pref
      t.integer :min_age
      t.integer :max_age
      t.string :date_type_pref
      t.string :lifestyle_pref

      t.timestamps
    end
  end
end
