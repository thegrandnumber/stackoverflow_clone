# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  question = Question.new(title: Faker::PhoneNumber.phone_number , content: Faker::Hacker.say_something_smart)
  if question.save
    3.times do
      question.answers.create(title: Faker::PhoneNumber.phone_number , content: Faker::Hacker.say_something_smart)
    end
  else
    p "Question didn't save!"
  end
end