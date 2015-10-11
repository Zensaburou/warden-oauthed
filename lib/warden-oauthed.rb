require 'warden'
require 'oauth2'
require 'multi_json'

module Warden
  module Oauthed
    class OauthedMisconfiguredError < StandardError; end
  end
end

require 'warden-oauthed/user'
require 'warden-oauthed/proxy'
require 'warden-oauthed/version'
require 'warden-oauthed/strategy'
