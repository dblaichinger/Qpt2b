class OrdersController < ApplicationController

	def create	
		order = Order.create(params[:user][:orders_attributes][0])
		user = User.create(params[:user])
	
		order.save
		user.save

		flash[:notice] = "Did it"
		redirect_to pages_home_path
	end

end
