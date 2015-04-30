class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.string  :title
      t.integer :required_quantity
      t.float   :price
      t.integer :completed_quantity
      t.text    :discreption

      t.timestamps null: false
    end
  end
end
