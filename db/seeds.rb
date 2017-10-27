# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Hữu Tình",
             email: "tinhhuu96@gmail.com",
             phone: "0912489574",
             address: "DN",
             password:              "123456",
             password_confirmation: "123456",
             admin:     true)
Category.create! name: "Iphone"
Category.create! name: "Ipad"
Category.create! name: "Watch"
Category.create! name: "Macbook"
Category.create! name: "IMac"

