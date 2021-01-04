class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.string :image_id
      t.text :introduction
      t.integer :price
      t.boolean :is_active, null: false, default: true
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
