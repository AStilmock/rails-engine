class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.find_by_id(params[:id]).nil?
      render json: { errors: "Merchant ID must be an integer" }, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end  end

  def search
    @merchant = Merchant.merchant_search(params[:name])
    if @merchant.empty?
      render json: MerchantSerializer.new(Merchant.new)
    else
      render json: MerchantSerializer.new(@merchant.first)
    end
  end
end
