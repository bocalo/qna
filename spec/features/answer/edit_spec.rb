require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  
  scenario 'Unauthenticated user can not edit answer' do
   
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'edits his answer', js: true do
      
      sign_in user
      visit question_path(question)
      #save_and_open_page
      click_on 'Edit'


      within '.answers' do
        fill_in 'Your answer', with: 'edited answer', match: :prefer_exact
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end
  #   scenario 'edits his answer with errors' do
      
  #   end

  #   scenario "tries to edit other user's question" do
      
  #   end
  # end
end
