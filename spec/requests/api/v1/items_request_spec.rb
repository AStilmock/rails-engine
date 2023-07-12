require 'rails_helper'

RSpec.describe "Item API" do
  describe "all items path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/items"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @items = @items_data[:data]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@items).to be_an(Array)

      @items.each do |item|
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it "gets all items" do
      get "/api/v1/items"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @items = @items_data[:data]

      expect(@items.first[:attributes][:name]).to eq(@item1.name)
      expect(@items.first[:attributes][:description]).to eq(@item1.description)
      expect(@items.first[:attributes][:unit_price]).to eq(@item1.unit_price)
      expect(@items.first[:attributes][:merchant_id]).to eq(@merchant1.id)
    end
  end

  describe "one item path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/items/#{@item3.id}"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @item = @items_data[:data][:attributes]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@item).to be_an(Hash)
    end

    it "gets one item" do
      get "/api/v1/items/#{@item3.id}"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @item = @items_data[:data][:attributes]

      expect(@item[:name]).to eq(@item3.name)
      expect(@item[:description]).to eq(@item3.description)
      expect(@item[:unit_price]).to eq(@item3.unit_price)
      expect(@item[:merchant_id]).to eq(@merchant3.id)
    end
  end

  describe "one item path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      @new_item = {
        "name": "water canister",
        "description": "holds water",
        "unit_price": 100,
        "merchant_id": "#{@merchant3.id}"
      }

      post "/api/v1/items", params: @new_item
      @new_item_data = JSON.parse(response.body, symbolize_names: true)
      @item = @new_item_data[:data][:attributes]

      expect(response.status).to eq(201)
      expect(response.body).to be_a(String)
      expect(@item).to be_an(Hash)
    end

    it "creates an item" do
      @new_item = {
        "name": "water canister",
        "description": "holds water",
        "unit_price": 100,
        "merchant_id": "#{@merchant3.id}"
      }

      post "/api/v1/items", params: @new_item
      @new_item_data = JSON.parse(response.body, symbolize_names: true)
      @item = @new_item_data[:data][:attributes]

      expect(@item[:name]).to eq(@new_item[:name])
      expect(@item[:description]).to eq(@new_item[:description])
      expect(@item[:unit_price]).to eq(@new_item[:unit_price])
      expect(@item[:merchant_id]).to eq(@new_item[:merchant_id].to_i)
    end
  end
end