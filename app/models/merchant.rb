class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices

  scope :filter_by_name, ->(name) { where('lower(name) LIKE ?', "#{name.downcase}%") }
  scope :filter_by_id, ->(id) {where id:id}
  scope :filter_by_created_at, ->(created_at) { where('Date(created_at) = ?', created_at.to_s) }
  scope :filter_by_updated_at, ->(updated_at) { where('Date(updated_at) = ?', updated_at.to_s) }

  def total_revenue
    invoices
      .joins(:transactions)
      .where(transactions: { result: 'success' })
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.most_revenue(limit)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(invoices: %i[invoice_items transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.most_items_sold(limit)
    select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
      .joins(invoices: %i[invoice_items transactions])
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('items_sold DESC')
      .limit(limit)
  end
end
