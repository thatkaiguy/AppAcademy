# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#seed subs
5.times do
  User.create!(username: Faker::Internet.user_name, password: "password")
end

10.times do
  Sub.create!(title: Faker::Lorem.word, description: Faker::Lorem.words(4).join(" "), moderator_id: rand(4) + 1)
end
