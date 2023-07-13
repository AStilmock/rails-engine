class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.find(params[:merchant_id]) == ActiveRecord::RecordNotFound
      render json: { errors: "Merchant ID must be an integer" }, status: 404
    else
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    end
  end

  # private
  #   def merchant_params
  #     params.permit(:merchant_id)
  #   end
end