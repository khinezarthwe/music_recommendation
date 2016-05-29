# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Khine Zar Thwe",
             email: "khinezar.awitd@gmail.com",
             password:              "khinezarthwe",
             password_confirmation: "khinezarthwe",
             age: 25,
             admin:true,
             activated:true,
             activated_at: Time.zone.now )

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               age: '26',
               activated: true,
               activated_at: Time.zone.now)
end
users = User.order(:created_at).take(6)
50.times do
  song_name = Faker::Lorem.sentence(5)
  artist_name = Faker::Lorem.sentence(5)
  lyric = Faker::Lorem.sentence(5)
  users.each {|user| user.songs.create!(song_name: song_name,artist_name: artist_name,lyric: lyric)}
end