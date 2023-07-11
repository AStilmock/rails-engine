class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
    render json: MerchantSerializer.new(@merchant)
  end
end
