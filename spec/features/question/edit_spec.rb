require 'rails_helper'

feature 'User can edit his question', %{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:other_user) { create(:user) }
  
  scenario 'Unauthenticated user can not edit question' do
    visit questions_path

    expect(page).to_not have_link 'Edit question'
  end

  describe 'Authenticated user', js: true do
    scenario 'edits own question' do
      sign_in user
      visit question_path(question)
    
      click_on 'Edit question'

      within '.question' do
        fill_in 'Your question', with: 'edited question title'
        fill_in 'Body question', with: 'edited question body'
        click_on 'Save question'

        expect(page).to have_content 'edited question title'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits own question with errors' do
      sign_in user
      visit question_path(question)

      click_on 'Edit question'

      within '.question' do
        fill_in 'Your question', with: ''

        click_on 'Save question'
        expect(page).to have_content "Title can't be blank"
      end
    end

    scenario 'tries to edit question of other user' do
      sign_in other_user
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to_not have_link 'Edit question'
    end
  end
end
