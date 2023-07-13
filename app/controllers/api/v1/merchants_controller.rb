class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def search
    render json: MerchantSerializer.new(Merchant.merchant_search(params[:name]))
    # @merchant = Merchant.merchant_search(params[:name])
    # if @merchant.empty?
    #   render json: MerchantSerializer.new(@merchant), status: 200
    # else 
    #   render json: MerchantSerializer.new(@merchant.first), status: 200
    # end
    # begin
    #   render json: MerchantSerializer.new(Merchant.merchant_search(params[:name]).first)
    # rescue ActiveRecord::InternalServerError => error
    #   render json: {
    #     errors: [
    #       {
    #         status: "500",
    #         title: error.message
    #       }
    #     ]
    #   }, status: 500
    # end
  end
end
