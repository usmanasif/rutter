require 'dotenv/load'
require './app.rb'
require 'rack/test'
require 'httparty'
require 'webmock/rspec'
require 'dotenv/load'
Dir['./services/*.rb'].sort_by { |path| path.count('/') }.each { |path| require path }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    Rutter.new
  end
end
