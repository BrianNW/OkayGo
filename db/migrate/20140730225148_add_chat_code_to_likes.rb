class AddChatCodeToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :code_chat, :integer
  end
end
