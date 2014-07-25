class AddImgToDeets < ActiveRecord::Migration
  def change
    add_column :deets, :img, :string
  end
end
