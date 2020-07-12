require 'rails_helper'

describe "Merchants API" do
  it "can create a new mercahnt" do
    merchant_params = {name: "Super Junior's Greatest Collection"}

    post '/api/v1/merchants' , params:{merchant: merchant_params}

    merchant = Merchant.last
  
    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end
end
