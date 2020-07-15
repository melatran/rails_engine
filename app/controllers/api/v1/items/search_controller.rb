class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(find_items(params).first)
  end

  def find_items(params)
    if params[:id]
      Item.where(id: params[:id])
    elsif params[:name]
      Item.where('lower(name) LIKE ?', "%#{params[:name].downcase}%")
    elsif params[:description]
      Item.where('lower(description) LIKE ?', "%#{params[:description.downcase]}%")
    elsif params[:created_at]
      Item.where('created_at LIKE ?', "%#{params[:created_at]}%")
    elsif params [:updated_at]
      Item.where('updated_at LIKE ?', "%#{params[:updated_at]}%")
    end
  end
end
