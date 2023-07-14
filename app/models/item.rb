class Item < ApplicationRecord
  validates_presence_of :name 
  validates_presence_of :description 
  validates_presence_of :unit_price
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.item_search(name)
    where("name ILIKE ?", "%#{name}%").order(:name)
  end

  def self.price_search(low_price, high_price)
    where("unit_price >= ?", "#{low_price}")
    .where("unit_price <= ?", "#{high_price}")
    .order(:unit_price)
  end
  
  def self.min_price_search(price)
    if price.to_i >= 0
      where("unit_price >= ? AND unit_price >= 0", "#{price}").order(:unit_price)
    end
  end

  def self.max_price_search(price)
    if price.to_i >= 0
      where("unit_price <= ? AND unit_price >= 0", "#{price}").order(:unit_price)
    end
  end
end