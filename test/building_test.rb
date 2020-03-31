require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
  end

  def test_existence
    assert_instance_of Building, @building
  end

  def test_attribute_access
    assert_equal [], @building.units
    assert_equal [], @building.renters
  end

end
