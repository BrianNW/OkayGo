class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :img
      t.integer :age
      t.string :gender
      t.string :bio

      t.timestamps
    end
  end
end
