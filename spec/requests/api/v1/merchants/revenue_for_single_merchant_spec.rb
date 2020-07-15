require 'rails_helper'

describe "For a single merchant" do
  it "can return the total revenue" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
    item_2 = create(:item, merchant_id: merchant_1.id, unit_price: 5.50)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
    transaction = create(:transaction, invoice_id: invoice_1.id, result: 'success')

    get "/api/v1/merchants/#{merchant_1.id}/revenue"

    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(json[:data][:attributes][:revenue]).to eq(25.50)
  end
end
