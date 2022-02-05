require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:url) {'https://google.com'}
  given(:url_1) {'https://yahoo.com'}
  given(:gist_url) { 'https://gist.github.com/bocalo/d0cf3e6b1b07ccd02100d04dd32e9e52' }
  given(:gist_url_1) { 'https://gist.github.com/bocalo/51860574fdc0dbf6d068cf18a64d6a36' }
  given(:invalid_url) { 'invalid_url' }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit new_question_path
    end

    scenario 'adds link asking question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'My gist' 
      fill_in 'Url', with: url

      click_on 'Ask'

      expect(page).to have_link 'My gist', href: url
    end

    scenario 'adds many links asking question', js: true do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: url

      click_on 'add link'

      within '.nested-fields' do
        fill_in 'Link name', with: 'My gist 1'
        fill_in 'Url', with: url_1
      end

      click_on 'Ask'

      expect(page).to have_link 'My gist', href: url
      expect(page).to have_link 'My gist 1', href: url_1
    end

    scenario 'tries to add invalid url address', js: true do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'My gist', match: :prefer_exact
      fill_in 'Url', with: invalid_url, match: :prefer_exact

      click_on 'Ask'
      expect(page).to have_content 'Links url is invalid'
    end

    scenario 'can add new link to gist editing question', js: true do
      
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'gist'
      fill_in 'Url', with: gist_url
      
      click_on 'Ask'
      

      expect(page).to have_link 'gist', href: gist_url
    end
  end
  
  scenario 'can add new links to gist editing question', js: true do
    sign_in(user)
    visit question_path(question)
    
    click_on 'Edit question'

    fill_in 'Title', with: 'edited question title', match: :prefer_exact
    fill_in 'Body', with: 'edited question body', match: :prefer_exact

    click_on 'add link', match: :prefer_exact

    
    fill_in 'Link name', with: 'My gist', match: :prefer_exact
    fill_in 'Url', with: gist_url, match: :prefer_exact
    

    click_on 'Save'
     
    
    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'deletes link editing question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    click_on 'add link'

    fill_in 'Link name', with: 'My url', match: :prefer_exact
    fill_in 'Url', with: url_1, match: :prefer_exact

    click_on 'Ask'

    click_on 'Delete link'

    expect(page).to_not have_link 'My url', href: url_1
  end
end

