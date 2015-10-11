module Warden
  module Oauthed
    module Oauth
      class User < Struct.new(:attribs, :token)
        ATTRIBUTES = (ENV['USER_ATTRIBUTES'] || 'id email').split(/\s/).freeze
        
        ATTRIBUTES.each do |name|
          define_method(name) { attribs[name] }
        end
        
      end
    end
  end
end
