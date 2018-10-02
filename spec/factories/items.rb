FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::FamousLastWords.last_word }
    unit_price { Faker::Number.between(1, 100000) }
    merchant
  end
end
