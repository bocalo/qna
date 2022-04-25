require 'rails_helper'

feature 'User can subscribe on the question', %q{
  For the information on new replies
  authenticate user
  can subscribe to the question
} do
  
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }

  describe 'Authenticated user', js: true do
    describe 'Author' do
      background do
        sign_in(author)
        visit question_path(question)
      end

      scenario 'can unsubscribe' do
        #save_and_open_page
        within('.subscription') do
          expect(page).to_not have_content 'Subscribe'
          expect(page).to have_content 'Unsubscribe'

          click_on 'Unsubscribe'

          expect(page).to have_content 'Subscribe'
          expect(page).to_not have_content 'Unsubscribe'
        end
      end
    end

    describe 'Another user' do
      before do
        sign_in(create(:user))
        visit question_path(question)
      end

      it 'can subscribe' do
        within('.subscription') do
          expect(page).to_not have_content 'Unsubscribe'
          expect(page).to have_content 'Subscribe'

          click_on 'Subscribe'

          expect(page).to have_content 'Unsubscribe'
          expect(page).to_not have_content 'Subscribe'
        end
      end
    end
  end

  describe 'Not authenticated user', js: true do
    background { visit question_path(question) }
 
    scenario 'can not subscribe or unsubscribe' do
      expect(page).to_not have_content 'Subscribe'
      expect(page).to_not have_content 'Unsubscribe'
    end
  end
end
