class AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def index
  	@title = "Admin"
    @trashcans = Trashcan.all
    @demands = Demand.find(:all, :order => "counter DESC")
    @pending_orders = Order.where(:status => "pending") 
    @processed_orders = Order.where("status != 'pending'")
  end
end
