FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    nickname { Faker::Name.unique.first_name }
    first_name { '佐藤' }
    last_name { '二郎' }
    first_name_kana { 'サトウ' }
    last_name_kana { 'ジロウ' }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end