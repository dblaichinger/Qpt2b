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
  attr_accessible :latitude, :longitude, :address, :counter

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
    "<h2>#{self.address}</h2><input class='voteButton' type='submit' value='Vote' onclick='vote(#{self.id})' onload='checkCookie()'><p class='markerInfo' style='display:inline; font-size: 12px;'></p><p>Current Votes: #{self.counter}</p>"
  end
end
