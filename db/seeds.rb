# Create 10 Random Users. User will be created with default role

puts "Seeding Users"

5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    confirmed_at: Date.today
  )
end

# Collect all the randomly seeded users
users = User.all

puts "Seeding Wikis"

# Create 20 Random Wikis.
20.times do
  Wiki.create!(
    title: Faker::Lorem.sentence(6),
    body: Faker::Lorem.paragraph(4),
    user_id: users.sample.id,
    private: false
  )
end

puts "Seeding Finished!"
puts "#{User.count} users seeded"
puts "#{Wiki.count} wikis seeded"
