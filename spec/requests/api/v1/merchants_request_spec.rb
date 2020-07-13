require 'rails_helper'

describe "Merchants API" do
  it "can send a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
  end

  it "can get one merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "can create a new mercahnt" do
    merchant_params = {name: "Super Junior's Greatest Collection"}

    post '/api/v1/merchants' , params:{merchant: merchant_params}

    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update a merchant" do
    merchant = create(:merchant)
    previous = Merchant.last.name
    merchant_params = {name: "GOT7 Goods"}

    patch "/api/v1/merchants/#{merchant.id}", params: {merchant: merchant_params}

    merchant = Merchant.find_by(id: merchant.id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous)
    expect(merchant.name).to eq("GOT7 Goods")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect{delete "/api/v1/merchants/#{merchant.id}"}.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
