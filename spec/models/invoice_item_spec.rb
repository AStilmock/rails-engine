require 'rails_helper'

RSpec.describe InvoiceItem do
  describe "validations" do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of :quantity}
  end

  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end