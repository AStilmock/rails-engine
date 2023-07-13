class Item < ApplicationRecord
  validates_presence_of :name 
  validates_presence_of :description 
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.item_search(name)
    where("name ILIKE ?", "%#{name}%").order(:name)
  end

  def self.price_search(low_price, high_price)
    # require 'pry'; binding.pry
    where("unit_price >= ?", "#{low_price}")
    .where("unit_price <= ?", "#{high_price}")
    # .order(:unit_price)
  end
  
  def self.min_price_search(price)
    where("unit_price >= ?", "#{price}").order(:unit_price)
  end

  def self.max_price_search(price)
    where("unit_price <= ?", "#{price}").order(:unit_price)
  end
end