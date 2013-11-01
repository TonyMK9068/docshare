user = User.new(
  username: 'member', 
  email:    'member@example.com', 
  password: 'helloworld',
  password_confirmation: 'helloworld')
user.skip_confirmation!
user.save


