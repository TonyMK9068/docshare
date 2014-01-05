n = 1
8.times do
  password = 'Password1'
  
  u = User.new(
    username: Faker::Name.first_name + 'test',
    email: "contact#{n}@anthonyjcorreia.com",
    password: password,
    password_confirmation: password
    )
  u.skip_confirmation!
  u.save!

  rand(1..3).times do
    p = u.pages.build(
      title: Faker::Lorem.words(rand(1..10)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n")
      )
      p.save
  end
  n += 1
end

user = User.new(
  username: 'test_member', 
  email:    'member@anthonyjcorreia.com', 
  password: 'Password1',
  password_confirmation: 'Password1'
  )
user.skip_confirmation!
user.save

user = User.new(
  username: 'subscriber1', 
  email:    'subscriber@anthonyjcorreia.com', 
  password: 'Password1',
  password_confirmation: 'Password1',
  subscriber: true
  )
user.skip_confirmation!
user.save

user = User.new(
  username: 'subscriber2', 
  email:    'test2@anthonyjcorreia.com', 
  password: 'Password1',
  password_confirmation: 'Password1',
  subscriber: true
  )
user.skip_confirmation!
user.save

user = User.new(
  username: 'subscriber3', 
  email:    'test3@anthonyjcorreia.com', 
  password: 'Password1',
  password_confirmation: 'Password1',
  subscriber: true
  )
user.skip_confirmation!
user.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Page.count} pages created"
