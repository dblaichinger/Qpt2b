require 'test_helper'

class DemandTest < ActiveSupport::TestCase

  test "vote count" do
    d = Demand.create(:address => "Plueddemanngasse 1, Graz", :counter => 0 )
    
    42.times do
      d.vote
    end

    assert_equal(d.counter, 42)
  end
end
