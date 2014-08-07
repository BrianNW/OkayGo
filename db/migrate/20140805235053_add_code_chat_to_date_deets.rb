class AddCodeChatToDateDeets < ActiveRecord::Migration
  def change
    add_column :date_deets, :code_chat, :integer
  end
end
