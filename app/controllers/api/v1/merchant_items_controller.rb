class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.find_by_id(params[:merchant_id]).nil?
      render json: { errors: "Merchant ID must be an integer" }, status: 404
    else
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    end
  end
end