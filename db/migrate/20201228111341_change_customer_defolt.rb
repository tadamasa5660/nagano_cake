class ChangeCustomerDefolt < ActiveRecord::Migration[5.2]
  def change
    change_column_default :customers, :is_active, :true
  end
end
