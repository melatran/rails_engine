class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant_results = search_params(params)
    render json: MerchantSerializer.new(merchant_results).serialized_json
  end

  def show
    merchant_results = search_params(params)
    render json: MerchantSerializer.new(merchant_results.first).serialized_json
  end

  private

  def search_params(params)
    merchant_results = Merchant.all
    merchant_results = merchant_results.filter_by_name(params[:name]) if params[:name].present?
    merchant_results = merchant_results.filter_by_id(params[:id]) if params[:id].present?
    merchant_results = merchant_results.filter_by_created_at(params[:created_at]) if params[:created_at].present?
    merchant_results = merchant_results.filter_by_updated_at(params[:updated_at]) if params[:updated_at].present?
    merchant_results
  end
end
