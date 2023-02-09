class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.find_by_id(params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    else
      render json: "", status: 404
    end
  end
end