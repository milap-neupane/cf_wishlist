class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
    	t.integer :item_count
    	t.float		:price
    	t.belongs_to :user

      t.timestamps null: false
    end
  end
end
