FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.between(1, 100) }
    unit_price { item.unit_price }
  end
end
