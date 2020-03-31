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

  def test_add_units
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    assert_equal [unit1, unit2], @building.units
  end

end
