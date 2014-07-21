class CreateFirstDates < ActiveRecord::Migration
  def change
    create_table :first_dates do |t|
      t.string :types

      t.timestamps
    end
  end
end
