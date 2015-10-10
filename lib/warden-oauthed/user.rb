module Warden
  module Oauthed
    module Oauth
      class User < Struct.new(:attribs, :token)
        ATTRIBUTES = %w[id full_name email].freeze

        
        ATTRIBUTES.each do |name|
          define_method(name) { attribs[name] }
        end
        
      end
    end
  end
end
