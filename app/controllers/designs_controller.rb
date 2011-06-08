class DesignsController < ApplicationController

	def index		
		# we dont need this actually
    UserMailer.order_confirmed(2).deliver
	end

	def create
	end
end
