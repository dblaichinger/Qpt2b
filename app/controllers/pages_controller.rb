class PagesController < ApplicationController
  def home
  	@user = User.new
  	order = @user.orders.build
	@json = Trashcan.all.to_gmaps4rails
  end

end
