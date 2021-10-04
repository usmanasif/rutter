require 'rubygems'
require 'bundler'
require './app'
require 'dotenv/load'

Dir['./services/*.rb'].sort_by { |path| path.count('/') }.each { |path| require path }

Bundler.require
run Rutter
