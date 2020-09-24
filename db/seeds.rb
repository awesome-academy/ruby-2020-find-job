# skills = ["html", "java", "css", "ios"]
# skills.each{|skill|
#   Skill.create!(
#     title: skill
#   )
# }

20.times do |n| 
  user_id = 1
  category_id = 2
  title = Faker::Job.title
  description = Faker::Lorem.paragraph
  salary = Faker::Number.number(digits: 6)
  address = Faker::Address.city
  target_type = "fulltime"
  start_date = Faker::Date.between(from: '2019-07-23', to: '2019-09-25')
  end_date = Faker::Date.between(from: '2019-09-25', to: '2020-09-25')

  Post.create!(
    user_id: user_id,
    category_id: category_id,
    title: title,
    description: description,
    salary: salary,
    address: address,
    target_type: target_type,
    start_date: start_date,
    end_date: end_date
  )
end
