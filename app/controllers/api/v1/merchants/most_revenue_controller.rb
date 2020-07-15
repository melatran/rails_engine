class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchant = Merchant.most_revenue(quantity)
    render json: MerchantSerializer.new(merchant)
  end
end
