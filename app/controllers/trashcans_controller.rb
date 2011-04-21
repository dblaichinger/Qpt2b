class TrashcansController < ApplicationController


def show
	@title = "Show trashcans"
	@trashcans = Trashcan.all
	

end



end
