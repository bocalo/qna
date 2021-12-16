require 'rails_helper'

feature 'User can delete own question', %q{
  In order to delete question
  As an authenticated User
  I'd like to be able to delete own question
} do
  given(:any_user) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: any_user) }

  scenario 'Any user tries to delete question' do
    sign_in(any_user)
    visit question_path(question)
    
    expect(page).to have_content question.title
    click_on 'Delete question'

    expect(page).to have_content 'Question successfully deleted.'
    expect(page).to_not have_content question.title
  end

  scenario 'Other authorized user tries to delete question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete question'
  end

  scenario 'Unauthorized user tries to delete question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete question'
  end
end
