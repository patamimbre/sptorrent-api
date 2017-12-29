ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../../app/app'

include Rack::Test::Methods

def app
  App
end
