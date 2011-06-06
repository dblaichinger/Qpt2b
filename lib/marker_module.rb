module MarkerModule
  def gmaps4rails_address
    self.address #describe how to retrieve the address from your model
  end

  def gmaps4rails_infowindow
    if self.is_free
      "<h2>#{self.address}</h2><input type='button' id='3' class='trashcanID' onclick='setTrashcanId(#{self.id})' value='Nimm mich!' />" 
    else
      "<h2>#{self.address}</h2><p>Hat einen Paten bis #{self.adopted_until}"
    end
  end
end
