class ChangeColumnDateInfoIdToDateDeetsId < ActiveRecord::Migration
  def change
    rename_column :user_dates, :date_info_id, :date_deets_id
  end
end
