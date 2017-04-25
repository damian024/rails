# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#require 'Flat'
#1.upto(10) do |i|
#Flat.([{
#          title: Faker::Name.title
#          size: Faker::Number.number(2)
#          rooms: Faker::Number.number(2)
#          price: Faker::Number.number(10)
#          description Faker::Lorem.paragraph(2)
#
# }])


50.times do |i|
  password = "Hasloo123"
  user = User.create(
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password)
    Flat.create(
        title: Faker::Name.title,
        size: Faker::Number.decimal(2),
        rooms: Faker::Number.number(2),
        price: Faker::Number.number(7),
        description: Faker::Hipster.paragraph,
        author: user.id,
        logitude: Faker::Number.number(2),
        latitude: Faker::Number.number(2)).save!
end
