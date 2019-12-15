require 'spec_helper'

describe Airplane do
  let(:plane) { Airplane.new(aircraft_type: :short_range,
                             sits_count: 156,
                             rows: 26,
                             row_arrangement: 'ABC_DEF') }

  context '#arrangement' do
    it 'returns row arrangement as hash in proper order' do
      expect(plane.arrangement).to match_array(['A', 'B', 'C', '_', 'F', 'E', 'D'])
    end
  end
end
