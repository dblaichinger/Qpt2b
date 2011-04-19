require 'test_helper'

class TrashcanTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "create trashcan" do
    t = Trashcan.create(:address => "Plueddemanngasse 1, Graz", :is_free => true )

    assert t != nil
    assert t.latitude && t.latitude != nil 
    assert t.longitude && t.longitude != nil
  end

  test "trashcan gmaps4rails_address" do
    t = Trashcan.create(:address => "Plueddemanngasse 1, Graz", :is_free => true )

    assert t.address = t.gmaps4rails_address
  end

  test "trashcan gmaps4rails_infowindow" do
    t = Trashcan.create(:address => "Plueddemanngasse 1, Graz", :is_free => true )

    answer = t.gmaps4rails_infowindow
    assert   answer && answer == t.address
  end
end
