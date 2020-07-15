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
  end

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end
end
