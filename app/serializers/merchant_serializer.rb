class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :id
  has_many :invoices
  has_many :items
end
