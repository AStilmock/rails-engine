class Invoice < ApplicationRecord
  validates_presence_of :status
  enum status: [:cancelled, :in_progress, :completed]

  belongs_to :customer
  belongs_to  :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
end