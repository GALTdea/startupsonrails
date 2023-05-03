# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

30.times.map do
  Company.create!(
    name: Faker::Company.name,
    url: Faker::Internet.url,
    email: Faker::Internet.email,
    user: User.first,
  )
end