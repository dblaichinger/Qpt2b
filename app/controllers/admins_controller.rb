class AdminsController < ApplicationController
  def index
    @trashcans = Trashcan.all
    @demands = Demand.all
    @orders = Order.all
  end

end
