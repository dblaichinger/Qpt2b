class DemandsController < ApplicationController
  protect_from_forgery :except => [:update]
  def index
    @markers = Demand.all.to_gmaps4rails
    #cookies["demand"] = {:value => "true", :expires => 1.second.from_now}
  end

  def update
      demand = Demand.find(params[:id])
      demand.vote

      flash.now[:notice] = "Deine Stimme war erfolgreich!"
      
      render :nothing => true, :status => 200
  end

end
