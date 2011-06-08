class OrdersController < ApplicationController

	def create

		#param = params[:user]
		#pw = { :password => Devise.friendly_token[0,20] }
		#merged_param = param.merge!(pw)

		@user = User.new (params[:user])
        if @user.save
          flash[:notice] = "Die Patenschaft wurde beantragt!"
          #UserMailer.order_recieved(@newUser).deliver
        else
          flash[:error] = "Die Bestellung ist fehlgeschlagen!"
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
