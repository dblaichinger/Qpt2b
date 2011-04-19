class PagesController < ApplicationController
  def home
  	@order = Order.new
    @markers = Trashcan.all.to_gmaps4rails
    puts @markers
  end

end
