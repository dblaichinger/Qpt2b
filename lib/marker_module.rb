module MarkerModule
  def gmaps4rails_address
    self.address #describe how to retrieve the address from your model
  end

  def gmaps4rails_infowindow
    "#{self.address} <input type='button' id='3' class='trashcanID' onclick='setTrashcanId(#{self.id})' value='Nimm mich!' />" #
  end
end
