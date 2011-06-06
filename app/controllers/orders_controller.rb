class OrdersController < ApplicationController

	def create

		#param = params[:user]
		#pw = { :password => Devise.friendly_token[0,20] }
		#p = param.merge!(pw)

		# TODO : 
		# => Validate Date
		# => Generate :code / :token
		# => improve error messages

		@newUser = User.new(:email => params[:user][:email], :name => params[:user][:name], :password => Devise.friendly_token[0,20], :street  => params[:user][:street], :city  => params[:user][:city])
		@order = Order.new(:owner_id => @newUser.id, :trashcan_id => params[:user][:orders_attributes]["0"][:trashcan_id], :design_id => params[:user][:orders_attributes]["0"][:design_id])

		if @newUser.save && @order.save
			flash[:notice] = "Die Patenschaft wurde beantragt!"
      UserMailer.order_recieved(@newUser).deliver
		else
			flash[:error] = "Die Bestellung ist fehlgeschlagen! #{params[:user][:orders_attributes]["0"][:trashcan_id]} - UID: #{@newUser.id}"
		end
		redirect_to pages_home_path
	end
end
