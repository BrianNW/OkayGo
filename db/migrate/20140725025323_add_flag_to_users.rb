class AddFlagToUsers < ActiveRecord::Migration
  
  def change
    change_table :users do |t|
    t.integer :flag
  end
end

end
