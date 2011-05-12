#coding: UTF-8
require 'test_helper'
class SlideHomeTest < ActionDispatch::IntegrationTest
  #fixtures :all
  include Capybara

  # Replace this with your real tests.
  test "the step-scroller link" do
  	visit pages_home_path
    assert page.has_link?("Schritt 2 >>")
  end
	
  test "nothing" do
    #Capybara.current_driver = :selenium
    #Demand.create(:address => "Urstein Süd 1, Puch b. Hallein", :counter => 5, :radius => 50)
    #visit pages_home_path
    #click_link "Voting"
    
    #page.find(:css, 'div#gmaps4rails_map').click
    #page.find(:css, '.ui-button')

    #assert page.click_button(".vote_button")
    assert true
  end

end
