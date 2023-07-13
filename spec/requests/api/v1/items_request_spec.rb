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

  describe "create item path" do
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

    it "creates item" do
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

  describe "edit an item path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      @item_update = {
        "name": "insulated tumbler",
        "description": "holds drinks",
        "unit_price": 200
      }
      
      put "/api/v1/items/#{@item3.id}", params: @item_update
      @item_update_data = JSON.parse(response.body, symbolize_names: true)
      @item = @item_update_data[:data][:attributes]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@item).to be_a(Hash)
    end

    it "updates item" do
      expect(@item3.name).to eq("water jug")
      expect(@item3.description).to eq("holds water")
      expect(@item3.unit_price).to eq(10)

      @item_update = {
        "name": "insulated tumbler",
        "description": "holds drinks",
        "unit_price": 200
      }
      
      put "/api/v1/items/#{@item3.id}", params: @item_update
      @item_update_data = JSON.parse(response.body, symbolize_names: true)
      @item = @item_update_data[:data][:attributes]

      expect(@item[:name]).to_not eq("water jug")
      expect(@item[:description]).to_not eq("holds water")
      expect(@item[:unit_price]).to_not eq(10)

      expect(@item[:name]).to eq("insulated tumbler")
      expect(@item[:description]).to eq("holds drinks")
      expect(@item[:unit_price]).to eq(200)
    end
  end

  describe "delete an item path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      delete "/api/v1/items/#{@item1.id}"
      
      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
    end

    it "deletes item" do
      expect(Item.count).to eq(3)
      delete "/api/v1/items/#{@item1.id}"

      expect(Item.count).to eq(2)
      expect{Item.find(@item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "items merchant path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/items/#{@item1.id}/merchant"
      @data_parse = JSON.parse(response.body, symbolize_names: true)
      @data = @data_parse[:data][:attributes]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@data).to be_a(Hash)
    end

    it "returns merchant data for the item" do
      get "/api/v1/items/#{@item1.id}/merchant"
      @data_parse = JSON.parse(response.body, symbolize_names: true)
      @data = @data_parse[:data][:attributes]

      expect(@data[:name]).to eq(@merchant1.name)
    end
  end

  describe "item search path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 50)
    end

    it "request successful" do
      get "/api/v1/items/find_all?name=atEr"
      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@search).to be_a(Array)
    end
    
    it "shows items from name search" do
      get "/api/v1/items/find_all?name=atEr"
      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]

      expect(@search.count).to eq(2)
      expect(@search.first[:attributes][:name]).to eq(@item2.name)
      expect(@search.second[:attributes][:name]).to eq(@item3.name)
    end

    it "shows items from min_price search" do
      get "/api/v1/items/find_all?min_price=20"
      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]

      expect(@search.count).to eq(2)
      expect(@search.first[:attributes][:name]).to eq(@item3.name)
      expect(@search.second[:attributes][:name]).to eq(@item1.name)
    end

    it "shows items from max_price search" do
      get "/api/v1/items/find_all?max_price=90"
      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]

      expect(@search.count).to eq(2)
      expect(@search.first[:attributes][:name]).to eq(@item2.name)
      expect(@search.second[:attributes][:name]).to eq(@item3.name)
    end

    it "shows items from min_max_price search" do
      get "/api/v1/items/find_all?min_price=20&max_price=90"
      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]

      expect(@search.count).to eq(1)
      expect(@search.first[:attributes][:name]).to eq(@item3.name)
    end
  end
end