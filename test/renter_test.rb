require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'

class RenterTest < Minitest::Test

  def test_existence
    renter1 = Renter.new("Jessie")
    assert_instance_of Renter, renter1
  end

  def test_attribute_access
    renter1 = Renter.new("Jessie")
    assert_equal renter1.name, "Jessie"
  end

end
