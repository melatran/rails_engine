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

      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)

      transaction = create(:transaction, invoice_id: invoice_1.id, result: 'success')

      expect(merchant_1.total_revenue).to eq(25.50)
      expect(merchant_1.total_revenue).to_not eq(40.50)
    end
  end

  describe ".class_methods" do
    # xit ".total_revenue_between_dates" do
    #   merchant_1 = create(:merchant)
    #   merchant_2 = create(:merchant)
    #
    #   item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
    #   item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
    #   item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 25.00)
    #
    #   invoice_1 = create(:invoice, merchant_id: merchant_1.id, created_at: "2017-03-18 07:13:13 UTC")
    #   invoice_2 = create(:invoice, merchant_id: merchant_2.id, created_at: "2017-02-28 07:13:13 UTC")
    #
    #   invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
    #   invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
    #   invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)
    #
    #   transaction = create(:transaction, invoice_id: invoice_1.id, result: 'success')
    #
    #   expect(Merchant.total_revenue_between_dates("2017-03-18")).to eq(5)
    # end

    it ".most_revenue" do
      merchant_1 = create(:merchant, id: 1)
      merchant_2 = create(:merchant, id: 2)
      merchant_3 = create(:merchant, id: 3)
      merchant_4 = create(:merchant, id: 4)

      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
      item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 25.00)
      item_4 = create(:item, merchant_id: merchant_3.id, unit_price: 15.00)
      item_5 = create(:item, merchant_id: merchant_4.id, unit_price: 15.00)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id)

      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)
      invoice_item_4 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_4.id, quantity: 3, unit_price: 15.00)

      transaction = create(:transaction, invoice_id: invoice_1.id, result: 'success')
      transaction = create(:transaction, invoice_id: invoice_2.id, result: 'success')
      transaction = create(:transaction, invoice_id: invoice_3.id, result: 'success')

      expect(Merchant.most_revenue(3)).to eq([merchant_3, merchant_1, merchant_2])
    end
  end
end
