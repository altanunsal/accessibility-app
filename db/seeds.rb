# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#  osm_data is the places found from OpenStreetMap, and populated with corresponding place_id from gMaps
osm_data = ActiveSupport::JSON.decode(File.read('db/montrealData.json'))

puts 'Seeding DB'
puts 'Seeding users'

User.destroy_all
User.create!(first_name: 'John', last_name:'Xu', email: 'johnbxu@gmail.com', phone_number: 5145145454, password: 'abc', password_confirmation: 'abc')
User.create!(first_name: 'Altan', last_name:'Unsal', email: 'altanunsal@gmail.com', phone_number: 5145145454, password: 'abc', password_confirmation: 'abc')
User.create!(first_name: 'Louis', last_name:'Riehl', email: 'louisriehl@gmail.com', phone_number: 5145145454, password: 'abc', password_confirmation: 'abc')

puts 'Seeding locations'
Location.destroy_all
osm_data.each do |place|
  if place["place_id"].include? "Ej"
    puts "skipping invalid location"
  else
    Location.create!(
      wheelchair: place["wheelchair"],
      bathroom: place["bathroom"],
      parking: place["parking"],
      place_id: place["place_id"],
      lat: place["lat"],
      lng: place["lng"]
    )
  end
end

puts 'Seeding contacts'
Contact.destroy_all
users = User.all
users.each do |user|
  user.contacts.create!(first_name: 'test1', last_name: 'test1', email: 'test1@test.test', phone_number: 1234567, emergency: true)
  user.contacts.create!(first_name: 'test2', last_name: 'test2', email: 'test2@test.test', phone_number: 1234567, emergency: true)
  user.contacts.create!(first_name: 'test3', last_name: 'test3', email: 'test3@test.test', phone_number: 1234567, emergency: true)
end

puts 'Seeding reviews'

Location.find(1).reviews.create!(user_id: 1, description: 'cool place!', rating: '5')
Location.find(1).reviews.create!(user_id: 1, description: 'cool place!', rating: '4')
Location.find(1).reviews.create!(user_id: 1, description: 'meh!', rating: '3')
Location.find(1).reviews.create!(user_id: 1, description: 'crappy place!', rating: '2')
Location.find(1).reviews.create!(user_id: 1, description: 'crappy place!', rating: '1')

puts 'Seeding trips (no trips yet)'
