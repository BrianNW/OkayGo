class RenameDateInUserDates < ActiveRecord::Migration
  def change
    rename_column :user_dates, :date_id, :date_info_id
  end
end
