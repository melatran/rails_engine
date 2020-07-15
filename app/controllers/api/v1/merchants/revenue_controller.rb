class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: MerchantRevenueSerializer.new(Merchant.find(params[:id]))
  end
end
