#encoding: UTF-8
class DemandsController < ApplicationController
  protect_from_forgery
  
def index
    @title = "Vote"
    markers = Demand.all | Trashcan.all
    @markers =  markers.to_gmaps4rails
    @top_demands = Demand.find(:all, :order => 'counter DESC', :limit => 6)
    @circles = Demand.all.map{|d| {:longitude => d.longitude, :latitude => d.latitude, :radius => d.radius}}.to_json
  end
  
  def destroy
	  Demand.find(params[:id]).destroy
	  flash[:sucess] = "Voting wurde gelöscht"
	  redirect_to admins_path
  end

  def edit
  	  @title = "Voting bearbeiten"
	  @demand = Demand.find(params[:id])
  end

  def update
    @demand = Demand.find(params[:id])

    if @demand.update_attributes(params[:demand])
      flash[:success] = "Voting aktualisiert!"
      redirect_to admins_path
    else
      render 'edit'
    end
  end

  def vote
      demand = Demand.find(params[:id])
      demand.vote
      cookies[:demand] = "true"

      render :nothing => true, :status => 200
  end
  
  def create
    Demand.create(:address => params[:address], :radius => 50, :counter => 0)
    render :nothing => true, :status => 200
  end
end
