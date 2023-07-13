class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
    # @item = Item.find(params[:id])
    # if @item.id.nil?
    #   render json: { errors: @item.errors.full_messages }, status: 400
    # else
    #   render json: ItemSerializer.new(Item.find(params[:id]))
    # end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: 400
    end
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

  def update
    @item = Item.find(params[:id].to_i)
    if @item.update(item_params)
      render json: ItemSerializer.new(@item)
    else
      render json: { errors: @item.errors.full_messages }, status: 400
    end
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

  def delete
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  def search
    if params[:name].present?
      render json: ItemSerializer.new(Item.item_search(params[:name]))
    elsif params[:min_price].present? && params[:max_price].present?
      render json: ItemSerializer.new(Item.price_search(params[:min_price], params[:max_price]))
    elsif params[:min_price].present? && params[:max_price].nil?
      render json: ItemSerializer.new(Item.min_price_search(params[:min_price]))
    elsif params[:min_price].nil? && params[:max_price].present?
      render json: ItemSerializer.new(Item.max_price_search(params[:max_price]))
    end
    # params[:name].present? && (params[:min_price].present? || params[:max_price].present? || params[:price].present?)
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

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end