class Order < ApplicationRecord
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }

  def full_name
    self.last_name + self.first_name
  end
end
