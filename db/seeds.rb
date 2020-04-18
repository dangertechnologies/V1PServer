# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"


# Create a fake business
business = Business.create!(
  name: "Demo",
  address: "Nowhere",
  phone_number: "0061475939303",
  description: "Example business",
  is_enabled: true,
  is_subscribed: true
)

# Create two more tiers for the business
business.tiers.create!(
  name: "VIP",
  color: "#840203"
)

business.tiers.create!(
  name: "Gold",
  color: "#F5A628"
)

# Create 50 fake users
fake_user_url = "https://randomuser.me/api/?results=50&format=json"
query = JSON.parse(open(fake_user_url).read, symbolize_names: true)

query[:results].each do |user|
  tier = business.tiers.sample
  u = User.create!(
    first_name: user[:name][:first].to_s,
    last_name: user[:name][:last].to_s,
    phone: user[:phone].to_s,
    card_number: (Random.rand * 1000000000000).to_i.to_s,
    tier: tier
  )
  puts user[:picture][:medium]
  u.avatar.attach(io: open(user[:picture][:medium]), filename: File.basename(user[:picture][:medium]))
end