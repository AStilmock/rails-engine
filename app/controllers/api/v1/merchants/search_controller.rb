class Api::V1::Merchants::SearchController < ApplicationController
  def search
    @merchant = Merchant.merchant_search(params[:name])
    if @merchant.empty?
      render json: MerchantSerializer.new(Merchant.new)
    else
      render json: MerchantSerializer.new(@merchant.first)
    end
  end
end