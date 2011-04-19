class DemandsController < ApplicationController
  def index
    @title = "Vote"
    @markers = Demand.all.to_gmaps4rails
  end

  def update
  demand = Demand.find(params[:id])
  demand.vote
  redirect_to demands_path
  end

end
