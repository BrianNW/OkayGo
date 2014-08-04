class AddStatusToDateInfos < ActiveRecord::Migration
  def change
    add_column :date_infos, :status, :string, :default => 'online'
  end
end