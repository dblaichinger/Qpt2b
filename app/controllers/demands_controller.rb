class DemandsController < ApplicationController
  def index
    @markers = Demand.all.to_gmaps4rails
  end

  def show
  demand = Demand.find(params[:id])
  demand.vote
  redirect_to demands_path
  end

end
