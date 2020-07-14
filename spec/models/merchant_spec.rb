require 'rails_helper'

describe Merchant do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many :items}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe "instance_methods" do
    it ".total_revenue" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
      item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 25.00)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id)

      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)

      transaction = create(:transaction, invoice_id: invoice_1.id, result: 'success')

      expect(merchant_1.total_revenue).to eq(25.50)
      expect(merchant_1.total_revenue).to_not eq(40.50)

    end
  end
end
