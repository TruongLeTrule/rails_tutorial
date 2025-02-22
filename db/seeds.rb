User.create! name: "Truong Le",
             email: "truong@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
end

users = User.order(:created_at).take 6

50.times do
  content = Faker::Lorem.sentence word_count: 5
  users.each{|user| user.microposts.create! content: content}
end

users = User.all
user = User.first
(2..20).each do |i|
  other_user = users[i]
  user.follow other_user
  other_user.follow user
end
