class OrdersController < ApplicationController

	def create

    @checkIfExists = User.find_by_email(params[:user][:email])
    
    if !@checkIfExists
		  @user = User.new (params[:user])
        if @user.save
          flash[:notice] = "Die Patenschaft wurde beantragt!"
          UserMailer.order_recieved(@user).deliver
        else
          flash[:error] = "Die Bestellung ist fehlgeschlagen!"
        end
    else
      flash[:notice] = "User gibbet scho!"
    end

		redirect_to pages_home_path
	end

  def confirm
    UserMailer.order_confirmed(params[:user_id])
  end

  def decline
    UserMailer.order_declined(params[:user_id])
  end

end
