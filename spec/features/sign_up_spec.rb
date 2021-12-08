require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign up
} do
  background { visit new_user_registration_path }

  feature 'User tries to sign up with' do
    background do
      fill_in 'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
    end

    scenario 'valid dates' do
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'invalid dates' do
      fill_in 'Password confirmation', with: '12345555'
      click_on 'Sign up'

      expect(page).to have_content "Password confirmation doesn't match"
    end
  end
end
