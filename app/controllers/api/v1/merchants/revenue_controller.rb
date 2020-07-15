class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new(Merchant.find(params[:id]))
  end
end
