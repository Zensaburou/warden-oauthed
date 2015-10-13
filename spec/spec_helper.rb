Bundler.require(:default, :runtime, :test)

require File.join(File.dirname(__FILE__), '..', 'lib', 'warden-oauthed')
require File.join(File.dirname(__FILE__), 'app')
require 'rack/test'
require 'webrat'
require 'addressable/uri'

require 'pp'

Webrat.configure do |config|
  config.mode = :rack
  config.application_port = 4567
end

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)

  config.before(:each) do
  end

  def app
    Example.app
  end
end

ENV['OAUTH_BASE_URL'] ||= 'http://localhost:3000'
ENV['APPLICATION_SCOPES_REQUESTED'] ||= 'public'
ENV['APPLICATION_CLIENT_ID'] ||= 'fd6df6f74658a9202d401aaba38223a7f79e7572926ce845e5268f5171e5b2d5'
ENV['APPLICATION_CLIENT_SECRET'] ||= 'afee0e20322e5d73dff82f29baf5989afd3422557056129aad29d974e56df677'
