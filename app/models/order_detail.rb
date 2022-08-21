class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum receive_status: { unable_make: 0, wait_make: 1, make_items: 2, complete_items: 3 }

  def subtotal
    (item.add_tax_price * amount)
  end
end
