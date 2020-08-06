skills = ["html", "java", "css", "ios"]
skills.each{|skill|
  Skill.create!(
    title: skill
  )
}

20.time do |n|
  title = Faker::Job.title
  description = Faker::Lorem.paragraph
  salary = Faker::Number.number(digits: 6)
  address = Faker::Address.city
  target_type = "fulltime"
  start_date = Faker::Date.between(from: '2019-07-23', to: '2019-09-25')
  end_date = Faker::Date.between(from: '2019-09-25', to: '2020-09-25')
  id = n+1

  Post.find_by(id: id).update!(
    title: title,
    description: description,
    salary: salary,
    address: address,
    target_type: target_type,
    start_date: start_date,
    end_date: end_date,)
end
