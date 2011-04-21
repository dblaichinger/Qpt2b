class TrashcansController < ApplicationController


def index
	@title = "Show trashcans"
	@trashcans = Trashcan.all
end

def destroy
	Trashcan.find(params[:id]).destroy
	flash[:sucess] = "Muelleimer wurde geloescht"
	redirect_to trashcans_path
end

def edit
	@trashcan = Trashcan.find(params[:id])
end

def update

end

end
