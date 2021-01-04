class RemoveEndUserIdFromCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :end_user_id, :integer
  end
end
