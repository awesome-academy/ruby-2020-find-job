FactoryBot.define do
  factory :experience do
    title {Faker::Name.name}
    description {Faker::Lorem.paragraph}
    profile {FactoryBot.create profile}
  end
end
