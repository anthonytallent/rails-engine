class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:name] && (params[:max_price] || params[:min_price])
      render json: { data: { errors: 'Error: Item Not Found' } }, status: 400
    elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
      render json: { data: { errors: 'Error: Item Not Found' } }, status: 400
    elsif params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%").sort
      render json: ItemSerializer.new(items)
    elsif params[:min_price] && params[:max_price]
      items = Item.where("unit_price >= ? and unit_price <= ?", params[:min_price].to_f, params[:max_price])
      render json: ItemSerializer.new(items)
    elsif params[:min_price]
      items = Item.where("unit_price >= ?", params[:min_price].to_f)
      render json: ItemSerializer.new(items)
    elsif params[:max_price]
      items = Item.where("unit_price <= ?", params[:max_price].to_f)
      render json: ItemSerializer.new(items)
    end
  end
end