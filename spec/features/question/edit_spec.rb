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

  describe 'Authenticated user' do
    describe 'Author' do
      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'edits own question', js: true do
        click_on 'Edit question'

        within '.question' do
          fill_in 'Your question', with: 'edited question title'
          fill_in 'Body question', with: 'edited question body'
          click_on 'Save question'

          expect(page).to have_content 'edited question title'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'edits own question with errors', js: true do
        click_on 'Edit question'

        within '.question' do
          fill_in 'Your question', with: ''

          click_on 'Save question'
          expect(page).to have_content "Title can't be blank"
        end
      end

      scenario 'edits his question with files', js: true do
        within '.question' do
          click_on 'Edit question'
          fill_in 'Your question', with: 'edited question title'
          fill_in 'Body question', with: 'edited question body'
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save question'

          expect(page).to have_link 'rails_helper.rb'
          expect(page).to have_link 'spec_helper.rb'
        end
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
