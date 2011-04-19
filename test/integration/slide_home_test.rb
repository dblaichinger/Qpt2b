require 'test_helper'
class SlideHomeTest < ActionDispatch::IntegrationTest
  #fixtures :all
  include Capybara

  # Replace this with your real tests.
  test "the navigation link" do
  	visit pages_home_path
    click_link "weiter zur Map >>"
  end
end
