require 'rails_helper'

feature 'Author can choose the best answer', %q{
  As the author of the question
  I'd like to choose the best answer
} do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe "Unauthenticated user" do
    scenario "can't choose the best answer" do
      visit question_path(question)
      expect(page).not_to have_link 'Best answer'
    end
  end

  describe 'Authenticated user' do
    describe 'if he is not the author of the question' do
      scenario "can't choose the best answer", js: true do
        sign_in other_user
        visit question_path(question)
        expect(page).not_to have_link 'Best answer'
      end
    end

    describe 'if he is the author of the question' do
      scenario 'can choose the best answer', js: true do
        
        sign_in user
        visit question_path(question)
        
        expect(page).not_to have_content 'The best answer'
        click_on 'Best answer'
        expect(page).to have_content 'The best answer'

        # within ".answers[data-answer-id='#{answer.id}']" do
        #   expect(page).not_to have_content 'The best answer'
          
        #   click_on 'Best answer'
        #   expect(page).to have_content 'The best answer'
        # end
      
      end
    end
  end
end
