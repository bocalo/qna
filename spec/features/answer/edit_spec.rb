require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do
  given!(:other_user) { create(:user) }
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  
  scenario 'Unauthenticated user can not edit answer' do
   
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end

  describe 'Authenticated user' do

    scenario 'edits his answer', js: true do
      sign_in user

      visit question_path(question)

      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'#, match: :prefer_exact
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors', js: true do
      sign_in user
      visit question_path(question)

      click_on 'Edit'

      within '.answers' do
        #fill_in 'Your answer', with: '', match: :prefer_exact
        fill_in 'Your answer', with: ''
        #save_and_open_page
        click_on 'Save'
        expect(page).to have_content "Body can't be blank"
      end
    end

    scenario "tries to edit other user's question" do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to have_content answer.body
      expect(page).to_not have_link 'Edit'
    end
  end
end
