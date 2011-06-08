module DemandModule
  def gmaps4rails_address
    self.address
  end

  def gmaps4rails_infowindow
    counter_class = "counter_" + self.id.to_s

    #the HTML that gets loaded into the info window. ugly but HAS TO be all inline!
    "<h2>#{self.address}</h2><input class='vote_button' type='submit' value='' onclick='voteClicked(#{self.id}, true)'><p class='markerInfo' style='display:inline; font-size: 12px;'></p><p>Current Votes: <span id='#{counter_class}'>#{self.counter}</span></p>"
  end
end
