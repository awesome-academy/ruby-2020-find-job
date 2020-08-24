FactoryBot.define do
  factory :company do
    logo {Settings.logo_company}  
    name {Faker::Company.name}
    email {Faker::Internet.email}
    phone {Settings.phone_number}
    address {Faker::Address.city}
    description {Faker::Lorem.paragraph}
  end
end
