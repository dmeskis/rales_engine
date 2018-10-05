FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::FamousLastWords.last_words }
    unit_price { Faker::Number.decimal(5, 2) }
    merchant
  end
end
