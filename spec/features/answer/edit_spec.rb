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
    describe 'author' do
      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'edits his answer', js: true do
        #save_and_open_page
        click_on 'Edit answer'

        within '.answers' do
          #fill_in 'Your answer', with: 'edited answer' #, match: :prefer_exact
          fill_in 'Your answer', with: 'edited answer'
          click_on 'Save'

          expect(page).to have_content answer.body
          expect(page).to have_content 'edited answer'
          expect(page).to have_selector 'textarea'
        end
      end

      scenario 'edits his answer with errors', js: true do
        click_on 'Edit answer'

        within '.answers' do
          fill_in 'Your answer', with: ''
          
          click_on 'Save'
          expect(page).to have_content "Body can't be blank"
        end
      end

      scenario 'edits his answer with files', js: true do
        click_on 'Edit answer'

        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          
          click_on 'Save'

          expect(page).to have_link 'rails_helper.rb'
          expect(page).to have_link 'spec_helper.rb'
        end
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
