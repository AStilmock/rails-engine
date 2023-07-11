class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_presence_of :result
  validates_presence_of :credit_card_expiration_date

  validates_numericality_of :credit_card_number
  validates_numericality_of :credit_card_expiration_date
  validates_numericality_of :result

  belongs_to :invoice

  enum result: [:success, :failed]
end