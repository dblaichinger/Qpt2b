#encoding: UTF-8

class OrdersController < ApplicationController

	def create

    @is_already_user = User.find_by_email(params[:user][:email])
    
    # Create new User and Order
    if !@is_already_user
		  @user = User.new (params[:user])
        if @user.save
          flash[:notice] = "Die Patenschaft wurde beantragt!"
          UserMailer.order_recieved(@user).deliver
        else
          flash[:error] = "Die Bestellung ist leider fehlgeschlagen!"
        end
    # Assign Order to existing User
    else
      @make_order = @is_already_user.orders.build(params[:user][:orders_attributes]["0"])
      if @make_order.save
        flash[:notice] = "Eine weitere Patenschaft wurde beantragt!"
        UserMailer.order_recieved(@is_already_user).deliver
      else
        flash[:error] = "Tut uns Leid, aber die Bestellung ist fehlgeschlagen!"
      end
    end

		redirect_to pages_home_path
	end

  def confirm
    UserMailer.order_confirmed(params[:user_id])
    flash.now[:success] = "Die Bestellung wurde bestätigt. Bitte ändern Sie die den Status des Mistkübel, sobald bezahlt wurde."
    redirect_to admins_path
  end

  def decline
    flash.now[:error] = "Die Bestellung wurde abgelehnt und der Benutzer informiert."
    UserMailer.order_declined(params[:user_id])
    redirect_to admins_path
  end

end
