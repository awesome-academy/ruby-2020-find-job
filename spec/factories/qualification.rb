FactoryBot.define do
  factory :qualification do
    title {Faker::Name.name}
    start_time {Faker::Date.between(from: "2020-09-25", to: "2020-12-30")}
    end_time {Faker::Date.between(from: "2014-09-25", to: "2020-07-30")}
    content {Faker::Lorem.paragraph}
    profile {FactoryBot.create profile}
  end    
end
