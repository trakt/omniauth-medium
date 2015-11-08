$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'omniauth/medium'

OmniAuth.config.test_mode = true

require "vcr"
require "webmock/rspec" # allow WebMock.stub_request to be used manually
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("[CLIENT_ID]") { ENV["CLIENT_ID"] }
  config.filter_sensitive_data("[CLIENT_SECRET]") { ENV["CLIENT_SECRET"] }
  config.filter_sensitive_data("[AUTH_CODE]") { ENV["AUTH_CODE"] }
end

require "dotenv"
Dotenv.load
