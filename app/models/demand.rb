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

  require 'demand_module.rb'
  include DemandModule

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
