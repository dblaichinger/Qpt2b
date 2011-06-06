class OrdersController < ApplicationController

	def create

		param = params[:user]
		pw = { :password => Devise.friendly_token[0,20] }
		mergedParam = param.merge!(pw)

		#@newUser = User.new(:email => params[:user][:email], :name => params[:user][:name], :password => Devise.friendly_token[0,20], :street  => params[:user][:street], :city  => params[:user][:city])
		#@newUser = User.new(:email => params[:user][:email], :name => params[:user][:name], :password => Devise.friendly_token[0,20])
		#@order = @newUser.orders.build(params[:user][:orders_attributes]["0"])

		@user = User.new
		@order = @user.orders.build(mergedParam)

		#@   = Group.find(params[:group_id])
        #@project = @group.projects.build(params[:project])      # build automatically sets the foreign_key
        if @order.save #&& @newUser.save
          flash[:notice] = "Die Patenschaft wurde beantragt!"
        else
          flash[:error] = "Die Bestellung ist fehlgeschlagen!"
        end

		redirect_to pages_home_path
	end
end