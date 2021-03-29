FactoryBot.define do
  factory :order_destination do
    token    { "pk_test_b9c57876f0a97bf84eff3901" }
    zipcode  { '123-4567' }
    area_id  { Faker::Number.between(from: 2, to: 48) }
    city     { "東京区"}
    address  { "東京777" }
    building { '東京ハイツ' }
    phone    { Faker::Number.number(digits: 11)}
    association :user
    item_id { 1 }
  end
end