module Helper
  def create_visitor
    User.destroy_all
    @user = User.new(
      username: 'testmember', 
      email:    'member@example.com', 
      password: 'helloworld',
      password_confirmation: 'helloworld')
  end

  def create_user
    User.destroy_all
    @user = User.new(
      username: 'testmember', 
      email:    'member@example.com', 
      password: 'helloworld',
      password_confirmation: 'helloworld')
    @user.skip_confirmation!
    @user.save!
  end


  def create_subscriber
          User.destroy_all
    @user = User.new(
      username: 'testmember', 
      email:    'member@example.com', 
      password: 'helloworld',
      password_confirmation: 'helloworld',
      subscriber: true)
    @user.skip_confirmation!
    @user.save!  
  end

  def fill_sign_up_form
    fill_in "user_username", :with => '#{@user[:username]}'
    fill_in "user_email", :with => '#{@user[:email]}'
    fill_in "user_password", :with => '#{@user[:password]}'
    fill_in "user_password_confirmation", :with => '#{@user[:password_confirmation]}'
    click_button 'Sign up'
  end

  def sign_in
    visit new_user_session_path
    fill_in("user_email", :with => @user[:email])
    fill_in("user_password", :with => @user[:password])
    click_button 'Log In'

  end

  def logout
    click_link('log out')
    page.has_link?('Sign in', visible: true)
  end

  def create_page
  Page.destroy_all
  page = @user.pages.build(title: "hello world hello world", body: "hello test testtest test test test test test")
  page.save!
  end

  def credit_card
    @card ||= { paymentNumber: '4242424242424242', paymentCVC: '456', paymentName: 'Test User', paymentExpiry: '07 / 14' }
  end
end

World(Helper)