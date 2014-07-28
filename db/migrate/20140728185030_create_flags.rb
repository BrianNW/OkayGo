class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags, :id => false do |t|
      t.integer :user_id
      t.integer :target_id
      t.timestamps
    end
  end
end