FactoryBot.define do
  factory :user do
    nickname  {Faker::Name.last_name}
    email     {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    lastname  {Faker::Japanese::Name.last_name}
    firstname {Faker::Japanese::Name.first_name}
    lastkana  {"カタカナ"}
    firstkana {"カタカナ"}
    birthday  {Faker::Date.birthday}
  end
end