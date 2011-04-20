class PagesController < ApplicationController
  def home
  	@title = "Home"
  	@user = User.new
  	order = @user.orders.build
    @markers = Trashcan.all.to_gmaps4rails

   
    @users_longitude = params[:longitude]
    @users_latitude = params[:latitude]


    if ((@users_longitude != nil) && (@users_longitude != nil))
		   @userpos = [description: "Dein Standort", title: "Dein Standort", sidebar: "", longitude: @users_longitude, latitude: @users_latitude, picture: "", width: "", height: ""]
   
		 
		  
		  @userpos = @userpos.to_json.to_s.chop
		  @userpos.slice!(0)
		  @markers = @markers.chop + "," + @userpos + "]"
	end

  end

  def info
  @title = "Info"
  end

end 

