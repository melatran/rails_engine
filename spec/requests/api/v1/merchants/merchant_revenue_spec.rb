require 'rails_helper'

describe "Find Across All Merchants" do
  scenario "It can return merchants with the most revenue" do
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

    get '/api/v1/merchants/most_revenue?quantity=2'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data].length).to eq(3)
    expect(json[:data].length).to_not eq(4)
  end
end
