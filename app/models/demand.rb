class Demand < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :latitude, :longitude, :address

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
end
