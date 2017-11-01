FactoryGirl.define do
  factory :product do
    name { Faker::Name.name }
    price 3000000
    quantity 100
    association :category, factory: :category
  end
end
