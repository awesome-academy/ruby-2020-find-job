FactoryBot.define do
  factory :comment do
    content {Faker::Job.title}
  end
end
