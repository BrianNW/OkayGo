class DropUsersLikes < ActiveRecord::Migration
  def change
    drop_table :users_likes
  end
end
