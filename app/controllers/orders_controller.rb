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
		Order.create(:owner_id => @newUser.id, :trashcan_id => params[:user][:orders_attributes]["0"][:trashcan_id], :design_id => params[:user][:orders_attributes]["0"][:design_id])

		if @newUser.save
			flash[:notice] = "Bestellung getaetigt !"
		else
			flash[:alert] = "Bestell Fehler !"
		end
		redirect_to pages_home_path
	end
end