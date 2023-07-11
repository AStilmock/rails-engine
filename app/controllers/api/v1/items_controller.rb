class Api::V1::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
    render json: ItemSerializer.new(@merchant_items)
  end
end