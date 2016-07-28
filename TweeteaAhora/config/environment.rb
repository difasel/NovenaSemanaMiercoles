# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Configura la base de datos y modelos 
require APP_ROOT.join('config', 'database')


CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "nfPgdwQB4sscL3tVQb9R2HQVk"
  config.consumer_secret     = "AXvAEzEHYjxNS1U3uI6O78Ts7QHnAR6EnXeBZx3fWcKtjuSxhs"
  config.access_token        = "148095865-S6zAXsAyk4R1jnRb0Ct6iiULFnMpn9V8FV1LqXVJ"
  config.access_token_secret = "ygFjaVJ6AeXkmoHIR2PnQQJph6t6dln1qxiEdN8MvdA4i"
end

