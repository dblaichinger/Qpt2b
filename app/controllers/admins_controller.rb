class AdminsController < ApplicationController
  def index
  	@title = "Admin"
    @trashcans = Trashcan.all
    @demands = Demand.find(:all, :order => "counter DESC")
    @orders = Order.all # TODO: add oder status -> only query unprocessed orders
  end
end
