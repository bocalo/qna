require 'rails_helper'

feature 'User can delete his answer', %q{
  As an authenticated User
  I'd like to be able to delete my answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Other authorized user tries to delete answer', js: true do
    sign_in(other_user)
    visit question_path(question)
    
    expect(page).to have_content answer.body
    expect(page).to_not have_link 'Delete answer'
  end

  scenario 'user can delete file', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Edit answer'
      attach_file 'Files', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Save'
    end

    expect(page).to have_link 'rails_helper'
    click_on 'Delete file'
    expect(page).to_not have_link 'rails_helper'
  end

  scenario 'Unauthorized user tries to delete answer', js: true do
    visit question_path(question)

    expect(page).to have_content answer.body
    expect(page).to_not have_link 'Delete answer'
  end

  
end
