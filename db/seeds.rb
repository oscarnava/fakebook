# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USER_COUNT = 20
POST_COUNT = 10

def create_user(username, email, password)
  User.create(
    username: username,
    email: email,
    password: password
  ).tap do |user|
    rand(POST_COUNT).times do
      user.posts.create(
        content: Faker::Hipster.paragraph,
        created_at: Faker::Date.backward(days: 14)
      )
    end
    warn "User #{user.username} created"
  end
end

create_user('Demo', 'demo@demo.com', 'demodemo')

USER_COUNT.times do
  create_user(Faker::Name.first_name + Faker::Name.middle_name, Faker::Internet.email, Faker::Lorem.characters(number: 10))
end
