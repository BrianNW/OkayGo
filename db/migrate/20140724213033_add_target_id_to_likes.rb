class AddTargetIdToLikes < ActiveRecord::Migration
    
    def change
      change_table :likes do |t|
        t.remove :up
        t.integer :target_id
        t.integer :user_id
    end
  end

end