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
  attr_accessible :latitude, :longitude, :address, :adopted_until, :is_free

  require 'trashcan_module.rb'
  include TrashcanModule

  has_many :orders

  def gmaps4rails_marker_picture
    pic_path = ""

    if self.is_free
      pic_path = "/images/icon_frei.png"
    else
      pic_path = "/images/icon_pate.png"
    end

   {
    "picture" => pic_path,
    "width" => "128",
    "height" => "128"
   }
  end

end
