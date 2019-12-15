require 'spec_helper'

describe 'Application' do
  context 'API' do
    before do
      post '/bookings', name: 'Jony', amount: 8
    end

    it 'shoulw book seats and return reserved seats' do
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq("A1,B1,C1,A2,B2,C2,A3,B3")
    end
  end
end