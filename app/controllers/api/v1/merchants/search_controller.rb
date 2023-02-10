class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").sort.first
    if params[:name].present? == false
      render json: "", status: 400
    elsif params[:name].empty?
      render json: "", status: 400
    elsif params[:name]
      # if Merchant.where("name ILIKE ?", "%#{params[:name]}%").sort.first == nil
      #   render json: { data: { error: "Merchant not found" } }, status: 200
      # end
        render json: MerchantSerializer.new(merchant)
    end
  end
end