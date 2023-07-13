class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchant_search(name)
    where("name ILIKE ?", "%#{name}%")
    .order(:name)
    .limit(1)
  end
end