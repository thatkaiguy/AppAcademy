# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sexes = ['M','F']
10.times do
  Cat.create!(
    name: Faker::Internet.user_name,
    sex:sexes.sample,
    birth_date: Faker::Date.backward(900)
  )
end
