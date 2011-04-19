require 'test_helper'

class TrashcanTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "create trashcan" do
    t = Trashcan.create(:address => "FH", :longitude => 47.724299, :latitude => 13.086305, :is_free => true )

    assert t != nil
    assert t.address == "FH"
    assert t.address = t.gmaps4rails_address

    answer = t.gmaps4rails_infowindow
    assert   answer && answer == t.address
  end

end
