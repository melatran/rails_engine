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
      invoice_2 = create(:invoice, merchant_id: merchant_2.id)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)

      create(:transaction, invoice_id: invoice_1.id, result: 'success')

      expect(merchant_1.total_revenue).to eq(25.50)
      expect(merchant_1.total_revenue).to_not eq(40.50)
    end
  end

  describe ".class_methods" do
    it ".most_revenue" do
      merchant_1 = create(:merchant, id: 1)
      merchant_2 = create(:merchant, id: 2)
      merchant_3 = create(:merchant, id: 3)
      merchant_4 = create(:merchant, id: 4)

      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
      item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 25.00)
      item_4 = create(:item, merchant_id: merchant_3.id, unit_price: 15.00)
      create(:item, merchant_id: merchant_4.id, unit_price: 15.00)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item_4.id, quantity: 3, unit_price: 15.00)

      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')
      create(:transaction, invoice_id: invoice_3.id, result: 'success')

      expect(Merchant.most_revenue(3)).to eq([merchant_3, merchant_1, merchant_2])
    end

    it ".most_items_sold" do
      merchant_1 = create(:merchant, id: 1)
      merchant_2 = create(:merchant, id: 2)
      merchant_3 = create(:merchant, id: 3)

      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
      item_3 = create(:item, merchant_id: merchant_3.id, unit_price: 25.00)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, quantity: 3, unit_price: 25.00)

      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')
      create(:transaction, invoice_id: invoice_3.id, result: 'success')

      expect(Merchant.most_items_sold(2)).to eq([merchant_1, merchant_3])
    end
  end
end
