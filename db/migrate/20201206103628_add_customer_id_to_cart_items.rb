class AddCustomerIdToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :customer_id, :integer
  end
end
