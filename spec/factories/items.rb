FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { "" }
    merchant_id { 1 }
  end
end
