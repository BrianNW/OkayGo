class CreateDeets < ActiveRecord::Migration
  def change
    create_table :deets do |t|
      t.string :about_me
      t.string :lifestyle
      t.string :profession

      t.timestamps
    end
  end
end
