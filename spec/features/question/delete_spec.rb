require 'rails_helper'

feature 'User can delete own question', %q{
  In order to delete question
  As  Authenticated User
  I`d like to be able to delete own question
} do
  given(:other_user) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: other_user) }

  scenario 'can delete own question' do
    sign_in(user)
    visit question_path(question)
    
    expect(page).to have_content question.title
    click_on 'Delete'
    
    expect(page).to have_content 'Question successfully deleted.'
    expect(page).to_not have_content question.title
  end

  scenario 'as other user tries to delete question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete question'
  end

  scenario 'Unauthenticated user tries to delete own question' do
    visit question_path(question)
    
    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete'
  end
end























