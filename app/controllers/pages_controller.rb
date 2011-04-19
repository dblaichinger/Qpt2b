class PagesController < ApplicationController
  def home
  	@user = User.new
  	order = @user.orders.build
    @markers = Trashcan.all.to_gmaps4rails
    puts @markers
  end

end
