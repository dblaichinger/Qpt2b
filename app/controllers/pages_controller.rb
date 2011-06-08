class PagesController < ApplicationController
  def home
  	@title = "Home"
  	#@user = User.new
  	#<%= form_for @order, :url => orders_path do |f| %>
  	@user = User.new
  	#@order.build_user
  	@order = @user.orders.build
  #@order.build.design
  
    @markers = Trashcan.all.to_gmaps4rails
  end

  def info
  	@title = "Information"
  end

end 