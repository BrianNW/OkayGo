class RemoveImgFromUsers < ActiveRecord::Migration
  def change
    remove_column :deets, :img
  end
end
