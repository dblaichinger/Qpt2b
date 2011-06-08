class PagesController < ApplicationController
  def home
  	@title = "Home"
  	#@user = User.new
  	#<%= form_for @order, :url => orders_path do |f| %>
  	@user = User.new
    @user.orders.build
  	#@order.build_user
  	#@order = @user.order.build
  #@order.build.design
  
    @markers = Trashcan.all.to_gmaps4rails
  end

  def info
  	@title = "Information"
  end

end 