class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.find_by_id(params[:id]).nil?
      render json: { errors: "Merchant ID must be an integer" }, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end  
  end
end
