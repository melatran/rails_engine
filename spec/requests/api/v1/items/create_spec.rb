require 'rails_helper'

describe 'Items API' do
  it 'can create new items' do
    merchant = create(:merchant)
    item_params = {
              name: 'Hairbrush',
              description: 'Get mermaid hair',
              unit_price: 21.00,
              merchant_id: merchant.id}

    post '/api/v1/items', params: item_params

    json = JSON.parse(response.body, symbolize_names: true)
    item = Item.last

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
  end
end
