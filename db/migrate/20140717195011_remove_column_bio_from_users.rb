class RemoveColumnBioFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :bio
  end
end
