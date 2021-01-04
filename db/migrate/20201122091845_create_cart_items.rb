class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :end_user_id
      t.integer :amount
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
