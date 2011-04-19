require 'test_helper'

class DemandTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "vote count" do
    d = Demand.create(:address => "FH", :longitude => 47.724299, :latitude => 13.086305, :counter => 0 )
    
    d.vote
    assert d.counter == 1
  end
end
