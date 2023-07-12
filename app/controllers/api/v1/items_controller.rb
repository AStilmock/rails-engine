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

  def update
    @item = Item.find(params[:id].to_i)
    if @item.update(item_params)
      render json: ItemSerializer.new(@item)
    else
      render json: { errors: @item.errors.full_messages }, status: 404
    end
  end

  def delete
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end