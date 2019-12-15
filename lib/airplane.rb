class Airplane
  attr_reader :rows, :row_arrangement

  def initialize(aircraft_type:, sits_count:, rows:, row_arrangement:)
    @aircraft_type = aircraft_type
    @sits_count = sits_count
    @rows = rows
    @row_arrangement = row_arrangement
  end

  def arrangement
    row_arrangement.split('_')
                   .each_with_index
                   .map { |seats, index| index.even? ? seats : seats.reverse }
                   .join('_')
                   .split('')
  end
end
