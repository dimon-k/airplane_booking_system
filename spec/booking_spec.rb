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

    context 'with 11 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Alex', 8]).to match_array(['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2'])
        expect(book['John', 3]).to match_array(['D1', 'E1', 'F1'])
      end
    end

    context 'with 20 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Filip', 5]).to match_array(['A1', 'A2', 'B1', 'B2', 'C1'])
        expect(book['Alfred', 2]).to match_array(['E1', 'F1'])
        expect(book['Zoe', 1]).to match_array(['D1'])
        expect(book['Katherine', 3]).to match_array(['D2', 'E2', 'F2'])
        expect(book['Paul', 7]).to match_array(['A3', 'A4', 'A5', 'B3', 'B4', 'C3', 'C4'])
        expect(book['Anvar', 2]).to match_array(['E3', 'F3'])
      end
    end

    context 'with 85 seats reservation in total' do
      it 'returns reserved seats' do
        expect(book['Filip', 6]).to match_array(['A1', 'A2', 'B1', 'B2', 'C1', 'C2'])
        expect(book['Alfred', 3]).to match_array(['D1', 'E1', 'F1'])
        expect(book['Zoe', 8]).to match_array(['D2', 'D3', 'E2', 'E3', 'E4', 'F2', 'F3', 'F4'])
        expect(book['Katherine', 4]).to match_array(['A3', 'A4', 'B3', 'B4'])
        expect(book['Paul', 7]).to match_array(['A5', 'A6', 'A7', 'B5', 'B6', 'C5', 'C6'])
        expect(book['Anvar', 7]).to match_array(['D5', 'D6', 'E5', 'E6', 'F5', 'F6', 'F7'])
        expect(book['Alex', 5]).to match_array(['A8', 'A9', 'B8', 'B9', 'C8'])
        expect(book['John', 1]).to match_array(['C3'])
        expect(book['Iosu', 2]).to match_array(['B7', 'C7'])
        expect(book['Gerard', 8]).to match_array(['D8', 'D9', 'E10', 'E8', 'E9', 'F10', 'F8', 'F9'])
        expect(book['Oriol', 4]).to match_array(['A10', 'A11', 'B10', 'B11'])
        expect(book['David', 6]).to match_array(['D11', 'D12', 'E11', 'E12', 'F11', 'F12'])
        expect(book['Marco', 1]).to match_array(['C4'])
        expect(book['Alik', 5]).to match_array(['A12', 'A13', 'B12', 'B13', 'C12'])
        expect(book['Kondar', 1]).to match_array(['D4'])
        expect(book['Mike', 7]).to match_array(['D13', 'D14', 'E13', 'E14', 'F13', 'F14', 'F15'])
        expect(book['Eugene', 2]).to match_array(['D7', 'E7'])
        expect(book['Lynn', 8]).to match_array(['A14', 'A15', 'A16', 'B14', 'B15', 'B16', 'C14', 'C15'])
      end
    end

    context 'with improper amount' do
      let(:error_message) { 'Reservation amount should be in range of 1 to 8 people' }

      it 'raises an error' do
        expect{book['Lynn', 0]}.to raise_error(RuntimeError, error_message)
        expect{book['Filip', 9]}.to raise_error(RuntimeError, error_message)
      end
    end
  end

  context '#show' do
    context 'with 6 seats reservation in total' do
      before do
        book['Gerard', 2]
        book['Marco', 3]
        book['John', 1]
      end

      it 'returns all reserved seats with the person who made a reservation' do
        expect(booking.show.count).to eq(3)
        expect(booking.show[0]['Gerard']).to match_array(['A1', 'B1'])
        expect(booking.show[1]['Marco']).to match_array(['D1', 'E1', 'F1'])
        expect(booking.show[2]['John']).to match_array(['C1'])
      end
    end
  end
end
