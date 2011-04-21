class TrashcansController < ApplicationController


def show
	@title = "Show trashcans"
	@trashcans = Trashcan.all
end

def destroy
	Trashcan.find(params[:id]).destroy
	flash[:sucess] = "Muelleimer wurde geloescht"
	redirect_to(:action => "show")
end

end
