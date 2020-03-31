require './lib/apartment'
require './lib/renter'

class Building
  attr_reader :units

  def initialize
    @units = []
    @renters = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    @renters = @units.map do |unit|
      if !unit.renter.nil?
        unit.renter.name
      end
    end
    @renters.compact
  end

end
