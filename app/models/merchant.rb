class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices

  def total_revenue
    invoices
      .joins(:transactions)
      .where(transactions: { result: 'success' })
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price')
    #start with invoices and transactions
    #transaction need to have result success to be paid invoice
    #total_revnue = quantity * unit_price (only invoice item table has relationship)
  end
end
