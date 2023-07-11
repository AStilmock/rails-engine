FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :invoice_item do
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    item
    invoice
  end

  factory :invoice do
    status { [0,1].sample }
    customer
    merchant
  end

  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end

  factory :merchant do
    name { Faker::Company.name }
  end

  factory :transaction do
    invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { [0,1].sample }
  end
end