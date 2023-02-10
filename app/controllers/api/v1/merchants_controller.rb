module Api
  module V1
    class MerchantsController < ApplicationController

      def index
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        merchant_id = Merchant.find(params[:id]).id
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
      end
    end
  end
end