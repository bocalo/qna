require 'rails_helper'

feature 'User can delete his question', %q{
  In order to delete own question 
  As an authenticated user
  I'd like to be able to delete my own question
} do
    given(:user) { create(:user) }
    given(:question) { create :question, user: user }
    given(:other_user) { create(:user) }

    scenario 'Authenticated user tries to delete his own question' do
      sign_in(user)
      visit question_path(question)

      click_on 'Delete'

      expect(page).to have_content 'Question successfully deleted.'
      expect(page).to_not have_content question.title
    end

    scenario 'Another user tries to delete his own question' do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to_not have_link 'Delete question'
    end

    scenario 'Unauthenticated user tries to delete his own question' do
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to_not have_link 'Delete question'
    end
end





















# feature 'User can delete his question', %q{
#   In order to delete own question 
#   As an authenticated user
#   I'd like to be able to delete the question
# } do

#     given(:user) { create(:user) }
#     given(:question) { create :question, user: user }
#     given(:other_user) { create(:user) }

#   scenario 'User tries to delete his own question' do
#     sign_in(user)
#     visit question_path(question)

#     expect(page).to have_content question.title

#     click_on 'Delete'

#     expect(page).to have_content 'Question successfully deleted.'
#     expect(page).to_not have_content question.title
#   end

#   scenario 'Other user tries to delete the question' do
    
#     sign_in(other_user)
#     visit question_path(question)
#     # save_and_open_page
#     expect(page).to have_content question.title
#     expect(page).to have_no_content 'Delete'
#   end
# end




# feature 'User can delete his question' do
#   let(:user) { create(:user) }
#   let(:other_user) { create(:user) }

#   let(:question) { create(:question, user: user) }

#   describe 'Authenticated user' do
#     background { sign_in(user) }

#     scenario 'Authenticated user can delete his question' do
#       visit question_path(question)

#       expect(page).to have_content question.body
#       expect(page).to have_content question.title
#       click_on 'Delete'

#       expect(page).to have_content 'Question successfully deleted.'
#       expect(current_path).to eq questions_path
#       expect(page).to have_no_content question.body
#       expect(page).to have_no_content question.title
#     end

#     scenario 'Authenticated user can not delete another question' do
#       question = create(:question, user: other_user)

#       visit question_path(question)

#       expect(page).to have_no_content 'Delete'
#     end
#   end

#   describe 'Non-authentcated user' do
#     scenario 'Non-authentcated user can not delete question' do
#       visit question_path(question)

#       expect(page).to have_no_content 'Delete'
#     end
#   end
# end
