class PagesController < ApplicationController
  def home
  	@title = "Home"
  	@user = User.new
  	order = @user.orders.build
    @markers = Trashcan.all.to_gmaps4rails
    puts @markers
  end

  def info
  @title = "Info"
  end

end 

