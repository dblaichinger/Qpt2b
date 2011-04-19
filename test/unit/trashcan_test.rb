require 'test_helper'

class TrashcanTest < ActiveSupport::TestCase

  test "create trashcan" do
    t = Trashcan.create(:address => "Plueddemanngasse 1, Graz", :is_free => true )

    assert_not_nil(t)
    assert_not_nil(t.latitude)
    assert_not_nil(t.longitude)
  end

  test "trashcan gmaps4rails_address" do
    t = Trashcan.create(:address => "Plueddemanngasse 1, Graz", :is_free => true )

    assert t.address = t.gmaps4rails_address

    answer = t.gmaps4rails_infowindow
    assert_equal(answer, t.address)
  end

end
