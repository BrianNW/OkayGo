class CreateLifestyles < ActiveRecord::Migration
  def change
    create_table :lifestyles do |t|
      t.string :types

      t.timestamps
    end
  end
end
