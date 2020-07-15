class Api::V1::RevenueController < ApplicationController
  def index
    revenue = Revenue.total_revenue_date_range(params['start'], params['end'])
    render json: RevenueSerializer.new(revenue)
  end
end
