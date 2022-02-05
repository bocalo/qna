require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given(:url) {'https://google.com'}
  given(:url_1) {'https://yahoo.com'}
  given(:gist_url) { 'https://gist.github.com/bocalo/d0cf3e6b1b07ccd02100d04dd32e9e52' }
  given(:invalid_url) { 'invalid_url' }


  describe 'Add links to new question' do
    background do
      sign_in(user)
      visit question_path(question)
    end
    
    scenario 'User adds link asking question', js: true do
      fill_in 'Body', with: 'text text text'
      click_on 'add link'
      
      fill_in 'Link name', with: 'My url', match: :prefer_exact
      fill_in 'Url', with: url, match: :prefer_exact
      
      click_on 'Create'
      

      within '.answers' do
        expect(page).to have_link 'My url', href: url
      end
    end

    scenario 'User tries to add an invalid url address', js: true do
      fill_in 'Link name', with: 'My url'
      fill_in 'Url', with: 'invalid_url'

      click_on 'Create'
    
      expect(page).to have_content 'Links url is invalid'
    end

    scenario 'User adds many links when answer question', js: true do

      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: url

      click_on 'add link'

      within '.nested-fields' do
        fill_in 'Link name', with: 'My gist 1'
        fill_in 'Url', with: url_1
      end

      click_on 'Create'
      
      expect(page).to have_link 'My gist', href: url
      expect(page).to have_link 'My gist 1', href: url_1
    end

    scenario 'User can add new links editing answer', js: true do
      fill_in 'Body', with: 'text text text'

      click_on 'Create'

      within '.answers' do
        click_on 'Edit answer'

        click_on 'add link'

        fill_in 'Link name', with: 'My url'
        fill_in 'Url', with: url

        click_on 'Save'
      end
      expect(page).to have_link 'My url', href: url
    end
  end
end

  

