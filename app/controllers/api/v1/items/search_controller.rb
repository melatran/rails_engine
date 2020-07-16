class Api::V1::Items::SearchController < ApplicationController
  def index
    item_results = search_params(params)
    render json: ItemSerializer.new(item_results).serialized_json
  end

  def show
    item_results = search_params(params)
    render json: ItemSerializer.new(item_results.first).serialized_json
  end

  private

  def search_params(params)
    item_results = Item.all
    item_results = item_results.filter_by_name(params[:name]) if params[:name].present?
    item_results = item_results.filter_by_id(params[:id]) if params[:id].present?
    item_results = item_results.filter_by_merchant_id(params[:merchant_id]) if params[:merchant_id].present?
    item_results = item_results.filter_by_description(params[:description]) if params[:description].present?
    item_results = item_results.filter_by_created_at(params[:created_at]) if params[:created_at].present?
    item_results = item_results.filter_by_updated_at(params[:updated_at]) if params[:updated_at].present?
    item_results
  end
end
