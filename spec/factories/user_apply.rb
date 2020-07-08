FactoryBot.define do
  factory :user_apply do
    post {FactoryBot.create post}
    user {FactoryBot.create user}
    profile {FactoryBot.create profile}
  end
end
