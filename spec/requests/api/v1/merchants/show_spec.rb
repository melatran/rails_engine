require 'rails_helper'

describe "Merchants API" do
  it "can get one merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
