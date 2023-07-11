require 'rails_helper'

RSpec.describe "Merchant API" do
  describe "all merchants route" do
    before :each do
      get "/api/v1/merchants"
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      @merchants = JSON.parse(response.body)
      @merch_response = File.read("./spec/fixtures/merchants_all.json")
      @merch_parse = JSON.parse(@merch_response, symbolize_names: true)
    end

    it "request successful" do
      expect(response.status).to eq(200)
      expect(response.body).to eq('{"data":[]}')
    end

    it "has content from serializer" do
      expected = {
        id: 1,
        name: "Schroeder-Jerde",
        created_at: "2012-03-27T14:53:59.000Z",
        updated_at: "2012-03-27T14:53:59.000Z"
      }
      expect(@merch_parse.first).to eq(expected)
    end
  end

  describe "single merchant route" do
    before :each do
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      get "/api/v1/merchants/#{@merchant1.id}"
      @merchants = JSON.parse(response.body)
      @merch_response = File.read("./spec/fixtures/merchants_show.json")
      @merch_parse = JSON.parse(@merch_response, symbolize_names: true)
    end

    it "shows one merchant from serializer" do
      expected = {
        "data": {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        }
      }
      expect(@merch_parse).to eq(expected)
    end
  end

  describe "merchant items route" do
    before :each do
      @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
      @item1 = Item.create!(name: "water bottle", description: "holds water", unit_price: 10, merchant_id: @merchant1.id)
      get "/api/v1/merchants/#{@merchant1.id}/items"
      @merchants = JSON.parse(response.body)
      @merch_response = File.read("./spec/fixtures/merchant_items.json")
      @merch_parse = JSON.parse(@merch_response, symbolize_names: true)
      @merch_data = @merch_parse[:data]
    end

    it "shows merchant items from serializer" do
      expected = {
        "name": "Item Nemo Facere",
        "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
        "unit_price": 42.91,
        "merchant_id": 1
      }
      expect(@merch_data.first[:attributes]).to eq(expected)
    end
  end
end