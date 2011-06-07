class OrdersController < ApplicationController

	def create

		param = params[:order]
		pw = { :password => Devise.friendly_token[0,20] }
		mergedParam = param.merge!(pw)

		#@newUser = User.new(:email => params[:user][:email], :name => params[:user][:name], :password => Devise.friendly_token[0,20], :street  => params[:user][:street], :city  => params[:user][:city])
		#@newUser = User.new(:email => params[:user][:email], :name => params[:user][:name], :password => Devise.friendly_token[0,20])
		#@order = @newUser.orders.build(params[:user][:orders_attributes]["0"])

		@order = Order.new(mergedParam)
		#@entry  = @order.build_user(mergedParam)

        if @order.save
          flash[:notice] = "Die Patenschaft wurde beantragt!"
        else
          flash[:error] = "Die Bestellung ist fehlgeschlagen!"
        end

		redirect_to pages_home_path
	end
end
