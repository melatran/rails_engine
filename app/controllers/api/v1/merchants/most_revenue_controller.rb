class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchant = Merchant.most_revenue(quantity = nil)
    render json: MerchantSerializer.new(merchant)
  end
end
