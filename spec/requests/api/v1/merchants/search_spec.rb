require 'rails_helper'

describe "Merchant Search Results" do
  scenario "User can get the result of the first name back" do
    create(:merchant, name: "Super Snax" )
    create(:merchant, name: "Supercali")

    get "/api/v1/merchants/find?name=super"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:attributes][:name]).to eq("Super Snax")
    expect(json[:data][:attributes][:name]).to_not eq("Supercali")
  end

  # scenario "User can get a list of all that match" do
  #   merchant = create(:merchant, name: "Super Snax" )
  #   merchant2 = create(:merchant, name: "Supercali")
  #
  #   get "/api/v1/merchants/find_all??name=super"
  #
  #   json = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(response).to be_successful
  # end
end
