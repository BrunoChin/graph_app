FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
  end
end
