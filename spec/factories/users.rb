FactoryBot.define do
  factory :user do
    transient do
      person {Gimei.name}
    end
    nickname  {Faker::Name.name}
    email     {Faker::Internet.free_email}
    password  {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    lastname  {person.last.kanji}
    firstname {person.first.kanji}
    lastkana  {person.last.katakana}
    firstkana {person.first.katakana}
    birthday  {Faker::Date.backward}
  end
end