class AdminsController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :is_admin

  def index
  	@title = "Admin"
    @trashcans = Trashcan.all
    @demands = Demand.find(:all, :order => "counter DESC")
    @orders = Order.all # TODO: add oder status -> only query unprocessed orders
  end

  def is_admin
  	#redirect_to pages_home_path unless current_admin?
  end
end