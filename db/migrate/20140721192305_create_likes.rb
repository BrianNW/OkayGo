class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :up

      t.timestamps
    end
  end
end
