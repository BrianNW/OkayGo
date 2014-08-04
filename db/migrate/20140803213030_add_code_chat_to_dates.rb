class AddCodeChatToDates < ActiveRecord::Migration
  def change
    add_column :dates, :likes_code_chat, :integer
  end
end
