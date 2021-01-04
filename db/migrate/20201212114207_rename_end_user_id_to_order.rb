class RenameEndUserIdToOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :end_user_id, :customer_id
  end
end
