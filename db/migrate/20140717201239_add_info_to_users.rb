class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :deets, :user_id, :integer
  end
end
