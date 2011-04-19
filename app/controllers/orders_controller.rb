class OrdersController < ApplicationController

	def create
		doOrder = user.orders.build(params[:user])#(:email => params[:user][:email], :name => params[:user][:name], :street  => params[:user][:street], :city  => params[:user][:city])
		doOrder.save

		flash[:notice] = "Did it"
		redirect_to pages_home_path
	end
end