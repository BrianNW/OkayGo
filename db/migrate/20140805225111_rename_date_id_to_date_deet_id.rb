class RenameDateIdToDateDeetId < ActiveRecord::Migration
  def change
    rename_column :user_dates, :date_id, :date_deets_id
    add_column :user_dates, :accepted, :boolean
  end
end
