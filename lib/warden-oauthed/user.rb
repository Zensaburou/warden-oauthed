module Warden
  module Oauthed
    module Oauth
      class User < Struct.new(:attribs, :token)
        def oauthed_raw_request(path, _params = {})
          puts "#{ENV['API_BASE_URL']}/#{path}"
          req = Faraday.new(url: "#{ENV['API_BASE_URL']}/#{path}")
          req.authorization :Bearer, token
          req.get.body
        end

        def oauthed_request(path, params = {})
          MultiJson.load(oauthed_raw_request(path, params))
        end
      end
    end
  end
end
