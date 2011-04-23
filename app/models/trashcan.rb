# == Schema Information
# Schema version: 20110419083731
#
# Table name: trashcans
#
#  id            :integer(4)      not null, primary key
#  address       :string(255)
#  latitude      :float
#  longitude     :float
#  is_free       :boolean(1)
#  adopted_until :date
#  created_at    :datetime
#  updated_at    :datetime
#

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
