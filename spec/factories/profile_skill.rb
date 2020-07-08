FactoryBot.define do
  factory :profile_skill do
    name {Faker::Job.key_skill}
    point {Faker::Number.within(range: 1..100)}
    profile {FactoryBot.create profile}
  end    
end
