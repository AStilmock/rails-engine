class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity 
  validates_presence_of :unit_price
  validates_numericality_of :quantity

  belongs_to :invoice
  belongs_to :item
end