class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true

  belongs_to :invoice
  has_many :merchants, through: :invoice

  scope :successful, -> { where(result: 'success') }
end
