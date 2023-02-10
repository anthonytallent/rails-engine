class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").sort.first
    if params[:name] == ""
      render json: { data: {errors: 'Error: Merchant Not Found' } }, status: 400
    elsif params[:name].present? == false
      render json: { data: {errors: 'Error: Merchant Not Found' } }, status: 400
    elsif params[:name] && merchant != nil
      render json: MerchantSerializer.new(merchant)
    else
      render json: { data: {errors: 'Error: Merchant Not Found' } }, status: 400
    end
  end
end