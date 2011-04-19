class Trashcan < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :latitude, :longitude, :address

  require 'marker_module.rb'
  include MarkerModule

  def gmaps4rails_marker_picture
   {
    "picture" => "/images/trash.jpg",
    "width" => "128",
    "height" => "128"
   }
  end
end
