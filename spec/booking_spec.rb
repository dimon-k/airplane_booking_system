require 'spec_helper'

describe Booking do
  let(:plane) { Airplane.new(aircraft_type: :short_range,
                                sits_count: 156,
                                rows: 26,
                                row_arrangement: ['ABC_DEF']) }

  describe '#book' do
    let(:booking) { described_class.new(plane) }
    let(:book) { ->(name, seats) { booking.book(name, seats) } }

    describe 'with 6 seats reservation in total' do
      it 'returns A1, B1, A2, B2 reserved sets' do
        expect(book['Marco', 4]).to eq(['A1', 'B1', 'A2', 'B2'])
      end

      it 'returns E1, F1 reserved sets' do
        expect(book['Gerard', 2]).to eq(['E1', 'F1'])
      end
    end

    describe 'with 8 seats reservation in total' do
      it 'returns A1, B1 reserved sets' do
        expect(book['Iosu', 2]).to eq(['A1', 'B1'])
      end

      it 'returns D1, E1, F1, E2, F2 reserved sets' do
        expect(book['Oriol', 5]).to eq(['D1', 'E1', 'F1', 'E2', 'F2'])
      end

      it 'returns A2, B2 reserved sets' do
        expect(book['David', 2]).to eq(['A2', 'B2'])
      end
    end

    describe 'with 4 seats reservation in total' do
      it 'returns A1, B1 reserved sets' do
        expect(book['Iosu', 2]).to eq(['A1', 'B1'])
      end

      it 'returns E1, F1 reserved sets' do
        expect(book['Gerard', 2]).to eq(['E1', 'F1'])
      end
    end
  end
end
