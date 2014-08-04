class RenameDateToDateDeets < ActiveRecord::Migration
  def change
    rename_table :dates, :date_deets
  end
end
