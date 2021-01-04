class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre

  attachment :image

end
