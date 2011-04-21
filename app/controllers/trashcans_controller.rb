class TrashcansController < ApplicationController
def index
	@title = "Show trashcans"
	@trashcans = Trashcan.all
end

def destroy
	Trashcan.find(params[:id]).destroy
	flash[:sucess] = "Muelleimer wurde geloescht"
	redirect_to admins_path
end

def edit
	@title = "Edit trashcan"
	@trashcan = Trashcan.find(params[:id])
end

def update
	 @trashcan = Trashcan.find(params[:id])

    if @trashcan.update_attributes(params[:trashcan])
      flash[:success] = "Muelleimer aktualisiert!"
      redirect_to trashcans_path
    else
      @title = "Edit trashcan"
      render 'edit'
    end
end

end
