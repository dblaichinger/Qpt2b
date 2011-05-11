#encoding: UTF-8
class TrashcansController < ApplicationController

def destroy
	Trashcan.find(params[:id]).destroy

	flash[:sucess] = "Mülleimer wurde gelöscht"
	redirect_to admins_path
end

def edit
	@title = "Mülleimer bearbeiten"
	@trashcan = Trashcan.find(params[:id])
end

def update
	 @trashcan = Trashcan.find(params[:id])

    if @trashcan.update_attributes(params[:trashcan])
      flash[:success] = "Mülleimer aktualisiert!"
      redirect_to trashcans_path
    else
      @title = "Mülleimer Standorte bearbeiten"
      render 'edit'
    end
end

end
