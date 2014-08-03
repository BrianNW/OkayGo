class CreateDates < ActiveRecord::Migration
  def change
    create_table :dates do |t|
      t.string :name
      t.string :img
      t.string :address
      t.float :latitude
      t.float :longitude
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
