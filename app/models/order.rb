class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum receive_status: { wait_payment: 0, confirm_payment: 1, make_items: 2, prepare_shipment: 3, complete_shipment: 4 }

end
