class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show

    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  # def new
  #   # require 'pry'; binding.pry
  #   new_item /= Item.new()
  # end

  def create
    item = Item.new(name: "water bottle", description: "holds water", unit_price: 10, merchant_id: 186)
    # require 'pry'; binding.pry
    if item.save
    render json: ItemSerializer.new(Item.last)
    else
      #  "ERROR - VALID DATA MUST BE ENTERED FOR ITEM CREATION"
      render json: { :errors => Item.errors.full_messages }
    end
  end

  def edit
  end

  def delete
  end
end