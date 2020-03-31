require './lib/apartment'
require './lib/renter'

class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    renters = @units.map do |unit|
      if !unit.renter.nil?
        unit.renter.name
      end
    end
    renters.compact
  end

  def average_rent
    rents = @units.map {|unit| unit.monthly_rent.to_f}
    rents.sum / @units.length
  end

  def rented_units
    @units.find_all {|unit| !unit.renter.nil?}
  end

  def renter_with_highest_rent
    highest_rented = rented_units.max_by {|unit| unit.monthly_rent}
    highest_rented.renter
  end
end
