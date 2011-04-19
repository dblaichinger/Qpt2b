require 'test_helper'

class DemandTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "vote count" do
    d = Demand.create(:address => "Plueddemanngasse 1, Graz", :counter => 0 )
    
    42.times do
      d.vote
    end

    assert d.counter == 42
  end
end
