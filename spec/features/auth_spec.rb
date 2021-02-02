require 'rails_helper'
require 'auth_helper'

feature 'AUTH SPEC - The root page' do

  scenario 'starts with nobody logged in' do

    visit root_url
    expect(page).to have_content "Sign Up or Log In"
  end

  scenario 'lists all the users' do
    
    capybara_sign_up_2_test_users!
    visit root_url

    expect(page).to have_content @test_user_1.username
    expect(page).to have_content @test_user_2.username
  end

end

feature 'The signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end
end

feature 'Signing up a user' do

  scenario 'shows username on the page after signup' do
      
      capybara_sign_up_test_user_1!
      
      expect(page).to have_content @test_user_1.username
  end

end

feature 'Logging in' do
  scenario 'shows username on the homepage after login' do
    test_user = create(:user)
    log_in_user!(test_user)
    
    expect(page).to have_content test_user.username
  end

end

feature 'logging out' do

  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).to have_content "Sign Up or Log In"
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    test_user = create(:user)
    log_in_user!(test_user)
    expect(page).to have_content test_user.username

    click_on "Log Out"
    expect(page).to have_content "Sign Up or Log In"
  end
  
end