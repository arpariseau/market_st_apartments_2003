require './lib/apartment'
require './lib/renter'
require 'pry'

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

  def units_by_number_of_bedrooms
    max_bedrooms = @units.max_by {|unit| unit.bedrooms}.bedrooms
    bedrooms = {}
    (1..max_bedrooms).each {|num| bedrooms[num] = []}
    @units.each {|unit| bedrooms[unit.bedrooms] << unit.number}
    bedrooms
  end

  def annual_breakdown
    breakdown = {}
    rented_units.each {|unit| breakdown[unit.renter.name] = (unit.monthly_rent * 12)}
    breakdown
  end

  def rooms_by_renter
    renter_rooms = {}
    rented_units.each do |unit|
      rooms = {bedrooms: unit.bedrooms, bathrooms: unit.bathrooms}
      renter_rooms[unit.renter] = rooms
    end
    renter_rooms
  end

end
