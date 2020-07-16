class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :filter_by_name, -> (name) { where('lower(name) LIKE ?', "#{name.downcase}%") }
  scope :filter_by_description, -> (name) { where('lower(description) LIKE ?', "#{description.downcase}%") }
  scope :filter_by_created_at, -> (created_at) { where("Date(created_at) = ?", "#{created_at}") }
  scope :filter_by_updated_at, -> (updated_at) { where("Date(updated_at) = ?", "#{updated_at}") }
end
