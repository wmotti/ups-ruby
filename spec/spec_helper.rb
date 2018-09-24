require 'dotenv/load'
require 'simplecov'
SimpleCov.start


path = File.expand_path('../../', __FILE__)
require "#{path}/lib/ups.rb"

require 'nokogiri'
require 'minitest/autorun'

require 'support/schema_path'
require 'support/shipping_options'
require 'support/xsd_validator'
