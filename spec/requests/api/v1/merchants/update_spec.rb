require 'rails_helper'

describe "Merchants API" do
  it "can update a merchant" do
    merchant = create(:merchant)
    previous = Merchant.last.name
    merchant_params = {name: "GOT7 Goods"}

    put "/api/v1/merchants/#{merchant.id}", params: {merchant: merchant_params}

    merchant = Merchant.find_by(id: merchant.id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous)
    expect(merchant.name).to eq("GOT7 Goods")
  end
end
