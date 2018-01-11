# Base Includes
require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'json'

# Let Bundler do it's magic
Bundler.require(:default)

# Data with Mongoid
Mongoid.load!('conf/mongoid.yml')
require_relative 'models/init'

# Application Configuration
require_relative 'conf/init'

# Main Application Skeleton
class App < Sinatra::Application

  # Configuration
  set :root, File.dirname(__FILE__)
  enable :sessions
  set :session_secret, CONF_SESSION_SECRET
  set :protection, :except => [:json_csrf]

  set :bind, "0.0.0.0"

  get '/' do
    content_type :json
    {'status'=>'OK'}.to_json
  end

end

# MonkeyPatch additional routes
require_relative 'routes/init'
