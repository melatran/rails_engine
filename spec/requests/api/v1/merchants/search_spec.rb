require 'rails_helper'

describe "Merchant Search Results" do
  scenario "User can get the result of the first name back" do
    create(:merchant, name: "Super Snax" )
    create(:merchant, name: "Supercali")

    get "/api/v1/merchants/find?name=super"

    json = JSON.parse(response.body, symbolize_names: true)
    name = json[:data][:attributes][:name].downcase

    expect(response).to be_successful
    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:attributes][:name]).to eq("Super Snax")
    expect(name).to include('super')
  end

  scenario "User can get the first result of created at" do
    create(:merchant, name: "SVU", created_at: "2019-03-18 12:00:30 UTC")
    create(:merchant, created_at: "2019-04-18 12:00:30 UTC")

    get "/api/v1/merchants/find?created_at=2019-03-18"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq("SVU")
  end

  scenario "User can get the first result of updated at" do
    create(:merchant, name: "I'm The King", updated_at: "2019-03-18 12:00:30 UTC")
    create(:merchant, updated_at: "2019-04-18 12:00:30 UTC")

    get "/api/v1/merchants/find?updated_at=2019-03-18"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq("I'm The King")
  end

  scenario "User can get multiple results for name back" do
    create(:merchant, name: "Super Snax" )
    create(:merchant, name: "Supercali")

    get "/api/v1/merchants/find_all?name=super"

    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(response).to be_successful
    expect(json[:data].count).to eq(2)
    expect(names.sort).to eq(["Super Snax", "Supercali"])
  end

  scenario "User can get multiple results for created at" do
    create(:merchant, name: "SVU", created_at: "2019-03-18 12:00:30 UTC")
    create(:merchant, name: "Just Stuff", created_at: "2019-03-18 12:00:30 UTC")
    create(:merchant, created_at: "2019-11-18 12:00:30 UTC")

    get "/api/v1/merchants/find_all?created_at=2019-03-18"

    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(response).to be_successful
    expect(json[:data].count).to eq(2)
    expect(json[:data].count).to_not eq(3)
    expect(names.sort).to eq(["Just Stuff", "SVU"])
  end
end
