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
      render json: ItemSerializer.new(@item), status: 201
    else
      render json: { errors: @item.errors.full_messages }, status: 400
    end
  end

  def update
    @item = Item.find(params[:id].to_i)
    if @item.update(item_params)
      render json: ItemSerializer.new(@item)
    else
      render json: { errors: @item.errors.full_messages }, status: 400
    end
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
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end