def sign_up_user!(username, password)
    visit new_user_url
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_on 'Sign Up!'
end

def log_in_user!(user)
  visit new_session_url
  fill_in 'Username', with: user.username
  fill_in 'Password', with: user.password
  click_on 'Log In!'
end

def capybara_sign_up_test_user_1!
    @test_user_1 = build(:user)
    sign_up_user!(@test_user_1.username, @test_user_1.password)
end

def capybara_sign_up_test_user_2!
    @test_user_2 = build(:user)
    sign_up_user!(@test_user_2.username, @test_user_2.password)
end

def capybara_sign_up_2_test_users!
    capybara_sign_up_test_user_1!
    capybara_sign_up_test_user_2!
    
end