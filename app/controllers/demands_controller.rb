class DemandsController < ApplicationController
  def index
    @markers = Demand.all.to_gmaps4rails
  end

end
