class RenameDateToDateDeets < ActiveRecord::Migration
  def change
    rename_table :date_infos, :date_deets
  end
end
