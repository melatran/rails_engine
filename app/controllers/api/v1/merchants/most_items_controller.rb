class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    merchant = Merchant.most_items_sold(quantity = nil)
    render json: MerchantSerializer.new(merchant)
  end
end
