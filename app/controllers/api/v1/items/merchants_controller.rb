class Api::V1::Items::MerchantsController < ApplicationController
  def show
    merchant_id = Item.find(params[:id]).merchant_id
    render json: MerchantSerializer.new(Merchant.find_by(id: merchant_id))
  end
end
