require 'rails_helper'

RSpec.describe "Item API" do
  describe "items API routes" do
    it "gets all items" do
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      @item1 = Item.create!(name: "water bottle", description: "holds water", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "water jug", description: "holds water", unit_price: 10, merchant_id: @merchant1.id)
      get "/api/v1/items"
      @items = JSON.parse(response.body)
      @item_response = File.read("./spec/fixtures/items_all.json")
      @item_parse = JSON.parse(@item_response, symbolize_names: true)
      @item_data = @item_parse[:data]

      expected = {
        "name": "Item Nemo Facere",
        "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
        "unit_price": 42.91,
        "merchant_id": 1
      }
      expect(@item_data.first[:attributes]).to eq(expected)
    end

    it "shows one item" do
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      @item1 = Item.create!(name: "water bottle", description: "holds water", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "water jug", description: "holds water", unit_price: 10, merchant_id: @merchant1.id)
      get "/api/v1/items/#{@item1.id}"
      @items = JSON.parse(response.body)
      @item_response = File.read("./spec/fixtures/items_show.json")
      @item_parse = JSON.parse(@item_response, symbolize_names: true)
      @item_data = @item_parse[:data]

      expected = {
        "name": "Item Nemo Facere",
        "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
        "unit_price": 42.91,
        "merchant_id": 1
      }

      expect(@item_data[:attributes]).to eq(expected)
    end

    it "creates an item" do
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      post "/api/v1/items"
      
      # @new_items = JSON.parse(response.body)
      # @new_response = File.read("./spec/fixtures/items_new.json")
      # @new_parse = JSON.parse(@new_response, symbolize_names: true)
      # @new_item_data = @item_parse[:data]


        # require 'pry'; binding.pry
      # expect(@item_data[:attributes].last).to eq(expected)

    end
  end
end