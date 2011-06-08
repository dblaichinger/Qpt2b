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
      else
        flash[:error] = "Tut uns Leid, aber die Bestellung ist fehlgeschlagen!"
      end
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
