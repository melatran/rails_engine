class Transaction < ApplicationRecord
  validates :result, presence: true
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
end
