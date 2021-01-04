class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method, default: 0, null: false, limit: 1
      t.integer :status, default: 0, null: false, limit: 1
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
