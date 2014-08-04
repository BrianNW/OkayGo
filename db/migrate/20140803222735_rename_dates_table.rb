class RenameDatesTable < ActiveRecord::Migration
  def change
    rename_table :dates, :date_infos
  end
end
