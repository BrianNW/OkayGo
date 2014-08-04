class AddAcceptedColumnToUserDates < ActiveRecord::Migration
  def change
    add_column :user_dates, :accepted, :boolean
  end
end
