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

password = "Hasloo123"

2.times do |i|
  user = User.create(
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password).save!
end

10.times do |i|
  user = User.find(User.pluck(:id).shuffle.first);
  place = nil
  loop do
   place = Geocoder.coordinates(Faker::Address.street_address);
  break if place != nil
  end
    Flat.create(
        title: Faker::Name.title,
        size: Faker::Number.decimal(2),
        rooms: Faker::Number.number(2),
        price: Faker::Number.number(7),
        description: '<b>' + Faker::Hipster.paragraph + '</b><br><br><i>'+ Faker::Hipster.paragraph + '</i>',
        author: user.id,
        longitude: place[1],
        latitude: place[0]).save!
end

15.times do |i|
  flat = Flat.new;
  user = User.new;
  loop do
    flat = Flat.find(Flat.pluck(:id).shuffle.first);
    user = User.find(User.pluck(:id).shuffle.first);
    break if(flat.author != user.id)
  end

  Conversation.create(
      flat: flat,
      user: user
  ).save!;
  end




40.times do |b|
    conversation = Conversation.find(Conversation.pluck(:id).shuffle.first);
    user = User.find(conversation.flat.author);
    Message.create(
        conversation:conversation,
        text: Faker::Hipster.paragraph,
        author: conversation.user.id
    ).save!
    Message.create(
        conversation:conversation,
        text: Faker::Hipster.paragraph,
        author: user.id
    ).save!
  end
