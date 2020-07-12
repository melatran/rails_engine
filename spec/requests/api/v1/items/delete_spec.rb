require 'rails_helper'

describe "Items API" do
  it 'can destroy an item' do
    item = create(:item)

    expect{delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
