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
    new_merchant = build(:merchant)
    post '/api/v1/merchants' , params: {name: new_merchant.name}

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = Merchant.last

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
    expect(merchant.name).to eq(new_merchant.name)
  end

  it "can update a merchant" do
    merchant_object = create(:merchant)
    merchant_params = build(:merchant)

    patch "/api/v1/merchants/#{merchant_object.id}", {params: merchant_params.attributes}

    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to_not eq(merchant_object.name)
    expect(json[:data][:attributes][:name]).to eq(merchant_params.name)
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect{delete "/api/v1/merchants/#{merchant.id}"}.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
