module MarkerModule
  def gmaps4rails_address
    self.address #describe how to retrieve the address from your model
  end

  def gmaps4rails_infowindow
    "#{self.address}"
  end
end
