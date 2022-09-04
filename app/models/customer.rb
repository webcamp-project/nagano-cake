class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :addresses
  has_many :orders

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana
    self.last_name_kana + "  " + self.first_name_kana
  end
end
