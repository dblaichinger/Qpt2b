class AdminsController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :is_admin

  def index
  	@title = "Admin"
    @trashcans = Trashcan.all
    @demands = Demand.find(:all, :order => "counter DESC")
    @pending_orders = Order.where(:status => "pending") 
    @processed_orders = Order.where("status != 'pending'")
  end

  def is_admin
  	#redirect_to pages_home_path unless current_admin?
  end
end
