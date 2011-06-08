require 'spec_helper'

describe 'blog post page' do
  it 'lets the user post a comment', :js => true do
    visit pages_home_path()
    fill_in 'user[email]', :with => 'J. Random Hacker'
    page.should have_content('Editor')
    #fill_in 'Comment', :with => 'Awesome post!'
    #click_on 'Submit'  # this be an Ajax button -- only works with Selenium
    #page.should have_content('has been submitted')
    #page.should have_content('Awesome post!')
  end
end