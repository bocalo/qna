require 'rails_helper'

feature 'User can look over list of questions', %q{
  In order to find question
  As a user
  I'd like to be able to look over list of questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  background { visit questions_path  }

  scenario 'Authenticated user can look over list of questions' do
    sign_in(user)

    questions.each do |question| 
      expect(page).to have_content(question.title) 
      expect(page).to have_content(question.body) 
    end
  end

  scenario 'Unauthenticated user can look over list of questions' do
    questions.each do |question| 
      expect(page).to have_content(question.title) 
      expect(page).to have_content(question.body) 
    end
  end
 end

