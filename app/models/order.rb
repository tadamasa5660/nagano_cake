class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  attr_accessor :address_status, :address_id

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4}
  enum address_status: {"自身の住所": 0, "登録住所": 1, "入力住所": 2}

end
