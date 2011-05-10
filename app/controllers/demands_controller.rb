class DemandsController < ApplicationController
  protect_from_forgery :except => [:update]
  def index
    @title = "Vote"
    @markers = Demand.all.to_gmaps4rails
    @circles = Demand.all.map{|d| {:longitude => d.longitude, :latitude => d.latitude, :radius => d.radius}}.to_json
  end
  
  def destroy
	  Demand.find(params[:id]).destroy
	  flash[:sucess] = "Voting-Zone wurde geloescht"
	  redirect_to admins_path
  end

  def edit
	  @demand = Demand.find(params[:id])
  end

  def update
    @demand = Demand.find(params[:id])

    if @demand.update_attributes(params[:demand])
      flash[:success] = "Demand-Zone aktualisiert!"
      redirect_to admins_path
    else
      render 'edit'
    end
  end

  def vote
      demand = Demand.find(params[:id])
      demand.vote

      render :nothing => true, :status => 200
  end
  
  def create
    Demand.create(:address => params[:address], :radius => 50, :counter => 0)
    render :nothing => true, :status => 200
  end
end
