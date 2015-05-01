class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
    	t.integer :item_count, default: 0
    	t.float		:price
    	t.belongs_to :user
    	t.belongs_to :wish_list

      t.timestamps null: false
    end
  end
end
