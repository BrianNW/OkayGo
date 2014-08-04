class RenameDateIdToDateDeets < ActiveRecord::Migration
  def change
    rename_column :user_dates, :date_id, :date_deet_id
  end
end
