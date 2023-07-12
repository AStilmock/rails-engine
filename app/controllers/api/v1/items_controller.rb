class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    end
  end

  # def edit
  # end

  # def delete
  # end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end