class PagesController < ApplicationController
  def home
  	@title = "Home"
  	#@user = User.new
  	#<%= form_for @order, :url => orders_path do |f| %>
  	@order = Order.new
  	@order.build_user
  	#order = @user.orders.build
    @markers = Trashcan.all.to_gmaps4rails
  end

  def info
  	@title = "Information"
  end

end 