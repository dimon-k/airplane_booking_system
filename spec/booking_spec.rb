require 'spec_helper'

describe Booking do
  let(:plane) { Airplane.new(aircraft_type: :short_range,
                             sits_count: 156,
                             rows: 26,
                             row_arrangement: 'ABC_DEF') }
  let(:booking) { described_class.new(plane) }
  let(:book) { ->(name, seats) { booking.book(name, seats) } }

  context '#book' do
    context 'with 6 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Marco', 4]).to match_array(['A1', 'B1', 'A2', 'B2'])
        expect(book['Gerard', 2]).to match_array(['E1', 'F1'])
      end
    end

    context 'with 8 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Iosu', 2]).to match_array(['A1', 'B1'])
        expect(book['Oriol', 5]).to match_array(['D1', 'E1', 'F1', 'E2', 'F2'])
        expect(book['David', 2]).to match_array(['A2', 'B2'])
      end
    end

    context 'with 4 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Iosu', 2]).to match_array(['A1', 'B1'])
        expect(book['Gerard', 2]).to match_array(['E1', 'F1'])
      end
    end
  end
end
