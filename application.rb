Dir['./lib/*.rb'].each { |file| require file }

require 'sinatra'

post '/bookings' do
  content_type :json

  booked = booking.book(params['name'], params['amount'].to_i)
  if booked
    status 201
    booked.join(',')
  else
    status 500
    booked.errors.full_messages
  end
end

private

def plane
  @plane ||= Airplane.new(aircraft_type: :short_range,
                          sits_count: 156,
                          rows: 26,
                          row_arrangement: 'ABC_DEF')
end

def booking
  @booking ||= Booking.new(plane)
end