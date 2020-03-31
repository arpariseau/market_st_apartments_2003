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
  end

  def test_add_units
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    assert_equal [unit1, unit2], @building.units
  end

  def test_get_renters
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Aurora")
    renter2 = Renter.new("Tim")

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    unit1.add_renter(renter1)
    assert_equal ["Aurora"], @building.renters
    unit2.add_renter(renter2)
    assert_equal ["Aurora", "Tim"], @building.renters
  end

  def test_get_average_rent
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    assert_equal 1099.5, @building.average_rent
  end

  def test_get_rented_units
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    @building.add_unit(unit3)
    assert_equal [], @building.rented_units
    unit2.add_renter(renter1)
    assert_equal [unit2], @building.rented_units
  end

  def test_find_highest_rent
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")
    renter2 = Renter.new("Jessie")
    renter3 = Renter.new("Max")

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    @building.add_unit(unit3)
    unit2.add_renter(renter1)
    assert_equal renter1, @building.renter_with_highest_rent
    unit1.add_renter(renter2)
    assert_equal renter2, @building.renter_with_highest_rent
    unit3.add_renter(renter3)
    assert_equal renter2, @building.renter_with_highest_rent
  end

  def test_units_by_number_of_bedrooms
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    @building.add_unit(unit1)
    @building.add_unit(unit2)
    @building.add_unit(unit3)
    @building.add_unit(unit4)

    expected_result = {3 => ["D4"], 2 => ["B2", "C3"], 1 => ["A1"]}
    assert_equal expected_result, @building.units_by_number_of_bedrooms
  end

  def test_annual_breakdown
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")
    renter2 = Renter.new("Jessie")

    @building.add_unit(unit1)
    @building.add_unit(unit2)
    @building.add_unit(unit3)
    unit2.add_renter(renter1)
    first_breakdown = {"Spencer" => 11988}
    assert_equal first_breakdown, @building.annual_breakdown
    unit1.add_renter(renter2)
    second_breakdown = {"Jessie" => 14400, "Spencer" => 11988}
    assert_equal second_breakdown, @building.annual_breakdown
  end

end
