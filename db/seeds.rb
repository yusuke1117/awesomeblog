# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#creating the first user
User.create!(
    name: "Yusuke Imamura",
    email: "yusuke@email.com",
    password: "password",
    password_confirmation: "password"

)
# creating many users
50.times do |n|
    name = Faker::Food.sushi
    email = "example#{n+1}@email.com"
    password = "password"
    User.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
    )
end

#microposts
users = User.order(:created_at).take(7) # The first 7 users will have microposts
50.times do 
    content = Faker::Lorem.sentence(5) # have at least 5 sentence from lorem ipsum faker
    users.each { |user| user.microposts.create!(content: content)} # makes the 7 users have lorem ipsum as their posts
end

# make fake users follow each other
users = User.all
user = users.first # this will be michael reevs
following = users[2..50]
followers = users[3..40]# From user_ID #3 to user_ID #40
following.each { |followed| user.follow(followed) } # the 1st user follows Following = users[2..50]
followers.each { |follower| follower.follow(user) } # from User_ID #3 to #40 ,they follow 1st user,michael reeves


