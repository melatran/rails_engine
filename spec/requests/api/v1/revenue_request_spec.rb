require 'rails_helper'

describe "Revenue For All Merchants" do
  it "returns the revenue across data range " do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
    item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5.50)
    item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 25.00)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, created_at: "2019-03-18 12:00:30 UTC")
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, created_at: "2019-03-01 12:00:30 UTC")

    create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10.00)
    create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 5.50)
    create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 25.00)

    create(:transaction, invoice_id: invoice_1.id, result: 'success')
    create(:transaction, invoice_id: invoice_2.id, result: 'success')

    get "/api/v1/revenue?start=2019-03-01&end=2019-03-18"

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json[:data][:attributes][:revenue]).to eq(50.5)
  end
end
