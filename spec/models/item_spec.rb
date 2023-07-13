require 'rails_helper'

RSpec.describe Item do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "methods" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
      @merchant2 = Merchant.create!(name: "Tom's Tools")
      @merchant3 = Merchant.create!(name: "Bill's Bikes")
      @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
      @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
      @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 50)
    end

    it "item_search" do
      @items = Item.item_search("atEr")
      expect(@items.count).to eq(2)
      expect(@items.first).to eq(@item2)
      expect(@items.second).to eq(@item3)
    end
    
    it "price_search" do
      @items = Item.price_search(10, 50)
      expect(@items.count).to eq(2)
      expect(@items.first).to eq(@item2)
      expect(@items.second).to eq(@item3)
    end

    it "min_price_search" do
      @items = Item.min_price_search(20)
      expect(@items.count).to eq(2)
      expect(@items.first).to eq(@item3)
      expect(@items.second).to eq(@item1)
    end

    it "max_price_search" do
      @items = Item.max_price_search(90)
      expect(@items.count).to eq(2)
      expect(@items.first).to eq(@item2)
      expect(@items.second).to eq(@item3)
    end
  end
end