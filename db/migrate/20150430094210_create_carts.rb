class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
    	t.belongs_to :user
    	t.belongs_to :wish_list

      t.timestamps null: false
    end
  end
end
