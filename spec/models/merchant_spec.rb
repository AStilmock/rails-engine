require 'rails_helper'

RSpec.describe Merchant do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do 
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices)}
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

    it "merchant_search" do
      @merchant = Merchant.merchant_search("iLl")
      expect(@merchant.count).to eq(1)
      expect(@merchant.first).to eq(@merchant3)
    end
  end
end