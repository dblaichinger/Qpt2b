# == Schema Information
# Schema version: 20110419083731
#
# Table name: demands
#
#  id         :integer(4)      not null, primary key
#  counter    :integer(4)
#  longitude  :float
#  latitude   :float
#  address    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Demand < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :latitude, :longitude, :address, :counter, :radius

  require 'marker_module.rb'
  include MarkerModule

  def gmaps4rails_marker_picture
   {
    "picture" => "/images/demand.png",
    "width" => "45",
    "height" => "45"
   }
  end

  def vote
    self.counter += 1
    self.save
  end

  def gmaps4rails_infowindow
    counter_class = "counter_" + self.id.to_s
    #the HTML that gets loaded into the info window. ugly but HAS TO be all inline!
    "<h2>#{self.address}</h2><input class='vote_button' type='submit' value='' onclick='voteClicked(#{self.id}, true)'><p class='markerInfo' style='display:inline; font-size: 12px;'></p><p>Current Votes: <span id='#{counter_class}'>#{self.counter}</span></p>"
  end
end
