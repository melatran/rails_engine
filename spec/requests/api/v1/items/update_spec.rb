require 'rails_helper'

describe 'Items API' do
  it 'can update an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    previous = Item.last.name
    item_params = {name: 'Mini Fan'}

    patch "/api/v1/items/#{item.id}", params: item_params

    item_object = Item.find_by(id: item.id)

    expect(response).to be_successful
    expect(item_object.name).to_not eq(previous)
    expect(item_object.name).to eq('Mini Fan')
  end
end
