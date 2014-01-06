module Helper
  def create_visitor

    @user = User.new(
      username: 'testermember', 
      email:    'tester@yahoo.com', 
      password: 'Helloworld2',
      password_confirmation: 'Helloworld2')
  end

  def create_user
    
    @user = User.new(
      username: 'testmember', 
      email:    'member@yahoo.com', 
      password: 'Helloworld2',
      password_confirmation: 'Helloworld2')
    @user.skip_confirmation!
    @user.save!
  end


  def create_subscriber

    @user = User.new(
      username: 'testermember', 
      email:    'member@yahoo.com', 
      password: 'Helloworld2',
      password_confirmation: 'Helloworld2',
      subscriber: true)
    @user.skip_confirmation!
    @user.save!
  end

  def fill_sign_up_form
    fill_in "user_username", :with => 'testermember'
    fill_in "user_email", :with => 'tester@yahoo.com'
    fill_in "user_password", :with => 'Helloworld2'
    fill_in "user_password_confirmation", :with => 'Helloworld2'
    click_button 'Sign up'
  end

  def sign_in
    within("form#new_user") do
    fill_in "user_email", :with => User.find(1).email
    fill_in "user_password", :with => 'Helloworld2'
  end
    click_on 'Log In'
    page.has_text?('Signed in successfully.')
  end

  def logout
    click_link('log out')
    page.has_link?('Sign in', visible: true)
  end

  def create_page
    @page = Page.new(title: "hello world hello world", body: "hello test testtest test test test test test", slug: "hello-world-hello-world")
  role = Role.create(page_id: 1, user_id: 1, status: 'owner')
    @page.save!
  end

  def credit_card
    card ||= { paymentNumber: '4242424242424242', paymentCVC: '456', paymentName: 'Test User', paymentExpiry: '07 / 14' }
  end
end

World(Helper)