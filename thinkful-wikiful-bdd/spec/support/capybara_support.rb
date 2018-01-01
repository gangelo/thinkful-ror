
module CapybaraHelpers
  def signup
    visit signup_path
    within(".form-container") do
      fill_in 'Name', with: 'Gene Angelo'
      fill_in 'User Name', with: 'gangelo'
      fill_in 'Email', with: 'iluv@cake.com'
      fill_in 'Password', with: 'ILuvC@k3'
      fill_in 'Password Confirmation', with: 'ILuvC@k3'
      click_button 'Sign Up'
    end
  end

  def login(user)
    visit login_path
    within(".form-container") do
      fill_in 'Email', with: user.email 
      fill_in 'Password', with: user.password 
      click_button 'Log In'
    end
  end

  def logout
    visit root_path
    click_link 'Log Out'
  end

  def current_path
    URI.parse(current_url).path
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, type: :feature
end