class PagesController < ApplicationController
  def home
  	@title = "Home"

  	@user = User.new
    @order = @user.orders.build
    @order.build_design
      
    @markers = Trashcan.all.to_gmaps4rails
  end

  def info
  	@title = "Information"
  end

end 