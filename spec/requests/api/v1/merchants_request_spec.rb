require 'rails_helper'

RSpec.describe "Merchant API" do
  describe "all merchants path" do 
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/merchants"
      @merchants_data = JSON.parse(response.body, symbolize_names: true)
      @merchants = @merchants_data[:data]

      expect(response.status).to eq(200)
      expect(@merchants).to be_an(Array)

      @merchants.each do |merchant|
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it "gets all merchants" do
      get "/api/v1/merchants"
      @merchants_data = JSON.parse(response.body, symbolize_names: true)
      @merchants = @merchants_data[:data]

      expect(@merchants.first[:attributes][:name]).to eq(@merchant1.name)
    end
  end

  describe "single merchant path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/merchants/#{@merchant1.id}"
      @merchants_data = JSON.parse(response.body, symbolize_names: true)
      @merchants = @merchants_data[:data]

      expect(response.status).to eq(200)
      expect(@merchants).to be_a(Hash)
    end

    it "gets one merchant" do
      get "/api/v1/merchants/#{@merchant1.id}"
      @merchants_data = JSON.parse(response.body, symbolize_names: true)
      @merchants = @merchants_data[:data]

      expect(@merchants[:id].to_i).to eq(@merchant1.id)
      expect(@merchants[:attributes][:name]).to eq(@merchant1.name)
    end
  end

  describe "merchant items path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/merchants/#{@merchant3.id}/items"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @items = @items_data[:data]

      expect(response.status).to eq(200)
      expect(@items).to be_an(Array)
    end
    
    it "shows merchant items" do
      get "/api/v1/merchants/#{@merchant3.id}/items"
      @items_data = JSON.parse(response.body, symbolize_names: true)
      @items = @items_data[:data]
      @item = @items.first[:attributes]

      @items.each do |item|
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:merchant_id]).to eq(@merchant3.id)
      end

      expect(@item[:name]).to eq(@item2.name)
      expect(@item[:description]).to eq(@item2.description)
      expect(@item[:unit_price]).to eq(@item2.unit_price)
      expect(@item[:merchant_id]).to eq(@merchant3.id)
    end
  end

  describe "merchant search path" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 10)
    end

    it "request successful" do
      get "/api/v1/merchants/find?name=iLl"

      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]
      @merchant_name = @search[:attributes]

      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(@merchant_name).to be_a(Hash)
    end
    
    it "shows merchant items" do
      get "/api/v1/merchants/find?name=iLl"

      @search_data = JSON.parse(response.body, symbolize_names: true)
      @search = @search_data[:data]
      @merchant_name = @search[:attributes][:name]

      expect(@merchant_name).to eq(@merchant3.name)
    end
  end
end