class PagesController < ApplicationController
  def home
  	@order = Order.new
	@json = Trashcan.all.to_gmaps4rails
  end

end
