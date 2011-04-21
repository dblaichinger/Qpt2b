class DemandsController < ApplicationController
  protect_from_forgery :except => [:update]
  def index
    @title = "Vote"
    @markers = Demand.all.to_gmaps4rails
    @circles = Demand.all.map{|d| {:longitude => d.longitude, :latitude => d.latitude, :radius => d.radius}}.to_json
  end

  def update
      demand = Demand.find(params[:id])
      demand.vote

      render :nothing => true, :status => 200
  end
  
  def create
    Demand.create(:address => params[:address], :radius => 500)
    render :nothing => true, :status => 200
  end

end
