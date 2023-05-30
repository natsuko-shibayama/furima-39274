FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    content { Faker::Lorem.sentence }
    price { Faker::Number.between(from: 300, to: 9999999) }
    category_name_id           {Faker::Number.between(from: 2, to: 11)}
    shipping_fee_payer_id       {Faker::Number.between(from: 2, to: 3)}
    prefecture_id        {Faker::Number.between(from: 2, to: 48)}
    shipping_day_id      {Faker::Number.between(from: 2, to: 4)}
    condition_id             {Faker::Number.between(from: 2, to: 7)}
    association :user, factory: :user
    after(:build) do |item|
      item.image.attach(io: File.open('images/sample.png'), filename: 'sample.png')
    end
  end


end
