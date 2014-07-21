class CreateUsersLikesJoinTable < ActiveRecord::Migration
  def change
    create_table :users_likes, :id => false do |t|
      t.integer :likes_id
      t.integer :user_id
    end

    add_index :users_likes, [:likes_id, :user_id]
  end
end
