require 'rails_helper'

describe "Items API" do
  it "can get one item by the id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:id]).to eq(item.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(item.name)
    expect(json[:data][:attributes][:description]).to eq(item.description)
    expect(json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end
end
