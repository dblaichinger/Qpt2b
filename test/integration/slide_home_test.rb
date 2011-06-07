#coding: UTF-8
require 'test_helper'
class SlideHomeTest < ActionDispatch::IntegrationTest
  #fixtures :all
  include Capybara
	
  test "nothing" do
    #Capybara.current_driver = :selenium
    Demand.create(:address => "Urstein Süd 1, Puch b. Hallein", :counter => 5, :radius => 50)
    visit demands_path
    id = Demand.last.id
    find(:css, "#" + id.to_s).click
  
    assert cookies[:demand] == "true"
    #page.find(:css, 'div#gmaps4rails_map').click
    #page.find(:css, '.ui-button')

  
    #assert page.click_button(".vote_button")
    assert true
  end

end
