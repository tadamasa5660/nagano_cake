class RenameEndUserIdToCustomerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :end_user_id, :customer_id
  end
end
