class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :id

  attributes :revenue do |merchant|
    merchant.attributes[:revenue]
  end
end
