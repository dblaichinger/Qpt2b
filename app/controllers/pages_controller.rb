class PagesController < ApplicationController
  def home
  	@title = "Home"

  	@user = User.new
    @order = @user.orders.build
    @order.build_design
      
    @markers = Trashcan.all.to_gmaps4rails
  end

  def gallery
      
  end

  def search
  
     # Gmaps4Rails.add_markers
     # params[:LatLng]
      #marker = new google.maps.Marker({position: object.latLng, map: Gmaps4Rails.map}


      render :nothing => true, :status => 200
  end

end 