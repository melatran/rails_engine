require 'rails_helper'

describe "Item Search Results" do
  xscenario "User can get the result of the first name back" do
    create(:item, name: "Super Snax")
    create(:item, name: "Supercali")

    get "/api/v1/items/find?name=super"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq("Super Snax")
    expect(json[:data][:attributes][:name]).to_not eq("Supercali")
  end
end
