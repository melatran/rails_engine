require 'rails_helper'

describe 'Merchant Index Relationship Endpoints' do
  it 'can return all items for that merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json[:data].first.count).to eq(3)
    expect(json[:data].first.count).to_not eq(4)
  end
end
