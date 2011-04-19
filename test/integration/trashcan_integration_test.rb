require 'test_helper'

class TrashcanIntegrationTest < ActionDispatch::IntegrationTest

	test "show pages/home" do
		get '/home'
		assert_response :sucess
	end

	test "show pages/info" do
		get '/info'
		assert_response :sucess
	end

end
