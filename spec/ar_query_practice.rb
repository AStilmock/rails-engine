require 'rails_helper'

RSpec.describe 'AR Query Practice' do
  describe "get merchants paths" do
    before :each do
      @merchant1 = Merchant.create!(name: "Baggins' Jewelry")
        @merchant2 = Merchant.create!(name: "Tom's Tools")
        @merchant3 = Merchant.create!(name: "Bill's Bikes")
        @item1 = @merchant1.items.create!(name: "gold ring", description: "is precious", unit_price: 111)
        @item2 = @merchant3.items.create!(name: "water bottle", description: "holds water", unit_price: 10) 
        @item3 = @merchant3.items.create!(name: "water jug", description: "holds water", unit_price: 50)
    end

    it "merchant with most revenue" do
      
    end
  end
end