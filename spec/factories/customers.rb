FactoryBot.define do
  factory :customer do
    first_name { Faker::ElderScrolls.first_name }
    last_name { Faker::ElderScrolls.last_name }
  end
end
