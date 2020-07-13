class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:id]).items
    render json: ItemSerializer.new(merchant_items)
  end
end
