require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'

class ApartmentTest < Minitest::Test

  def setup
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
  end

  def test_existence
    assert_instance_of Apartment, @unit1
  end

  def test_attribute_access
    assert_equal "A1", @unit1.number
    assert_equal 1200, @unit1.monthly_rent
    assert_equal 1, @unit1.bathrooms
    assert_equal 1, @unit1.bedrooms
    assert_nil @unit1.renter
  end

  def test_add_renter
    renter1 = Renter.new("Jessie")
    @unit1.add_renter(renter1)
    assert_equal renter1, @unit1.renter
  end

end
