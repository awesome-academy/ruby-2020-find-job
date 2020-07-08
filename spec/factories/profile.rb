FactoryBot.define do
  factory :profile do
    title {Faker::Name.name}
    position {Faker::Job.position}
    address {Faker::Address.city}
    email {Faker::Internet.email}
    phone {"0123456"}
    education {Faker::Lorem.paragraph}
  end    
end
