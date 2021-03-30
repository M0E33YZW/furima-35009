FactoryBot.define do
  factory :order_destination do
    token    { ENV["PAYJP_PUBLIC_KEY"] }
    zipcode  { '123-4567' }
    area_id  { Faker::Number.between(from: 2, to: 48) }
    city     { '東京区' }
    address  { '東京777' }
    building { '東京ハイツ' }
    phone    { Faker::Number.number(digits: 11) }
  end
end
