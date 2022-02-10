require 'rails_helper'

feature 'User can vote for a question', %q{
  In order to show that question is good
  As an authenticateed user
  I'd like to be able to vote
} do
  
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }

  describe 'User is not an author of the question', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end
  
    scenario 'votes up for question' do
      #save_and_open_page
      within(all('.question')[0]) do
        click_on 'vote up'

        within '.vote-result' do
          expect(page).to have_content '1'
        end
      end
    end
  end
end
