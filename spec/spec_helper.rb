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

module Minitest::Assertions
  def assert_valid_UPS_label_url(url)
    uri = URI.parse url
    assert uri.scheme == 'https', 'Invalid scheme'
    assert uri.host == 'www.ups.com', 'Invalid host'
    assert_match %r{/uel/llp/1Z[[:alnum:]]{6}[[:digit:]]{10}/link/labelAll/XSA/[[:alnum:]]{44}/[[:lower:]]{2}_[[:upper:]]{2}}, uri.path, 'Invalid path'
    assert_match %r{loc=[[:lower:]]{2}_[[:upper:]]{2}&cie=true&pdr=false}, uri.query, 'Invalid query'
  end

  def assert_valid_UPS_receipt_url(url)
    uri = URI.parse url
    assert uri.scheme == 'https', 'Invalid scheme'
    assert uri.host == 'www.ups.com', 'Invalid host'
    assert_match %r{/uel/llp/1Z[[:alnum:]]{6}[[:digit:]]{10}/link/receipt/XSA/[[:alnum:]]{44}/[[:lower:]]{2}_[[:upper:]]{2}}, uri.path, 'Invalid path'
    assert_match %r{loc=[[:lower:]]{2}_[[:upper:]]{2}&cie=true&pdr=false}, uri.query, 'Invalid query'
  end
end

String.infect_an_assertion :assert_valid_UPS_label_url, :must_be_a_valid_UPS_label_url, :reverse
String.infect_an_assertion :assert_valid_UPS_receipt_url, :must_be_a_valid_UPS_receipt_url, :reverse
