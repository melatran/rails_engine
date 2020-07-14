class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
end
