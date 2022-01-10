require 'rails_helper'

feature 'User can create answer', %q{
  In order to get answer to a community
  As an authenticated user
  I'd like to be able to write the answer to the question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user can create' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'answer the question', js: true do
      fill_in 'Body', with: 'text text text'
      click_on 'Create'
      
      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'text text text'
      end
    end
    
    scenario 'answer with errors', js: true do
      
      click_on 'Create'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer the question' do
    visit question_path(question)
    
    expect(page).to_not have_link "Create"
  end
end
