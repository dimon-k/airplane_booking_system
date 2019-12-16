Dir['./lib/*.rb'].each { |file| require file }

require 'rack/test'
require 'rspec'
require 'ffaker'

ENV['RACK_ENV'] = 'test'

require './application.rb'

module RSpecMixin
  include Rack::Test::Methods

  def app()
    Sinatra::Application
  end
end

RSpec.configure { |config| config.include RSpecMixin }
