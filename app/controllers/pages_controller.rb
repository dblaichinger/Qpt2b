class PagesController < ApplicationController
  def home
  	@order = Order.new
  end

end
