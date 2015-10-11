module Warden
  module Oauthed
    module Oauth
      class Proxy
        attr_accessor :client_id, :secret, :scopes, :oauth_domain, :callback_url
        def initialize(client_id, secret, scopes, oauth_domain, callback_url)
          @client_id, @secret, @scopes, @oauth_domain, @callback_url = client_id, secret, scopes, oauth_domain, callback_url
        end

        def ssl_options
          { version: :TLSv1 }
        end

        def client
          @client ||= OAuth2::Client.new(@client_id, @secret,
            ssl: ssl_options,
            site: oauth_domain,
            authorize_url: '/oauth/authorize')
        end

        def api_for(code)
          client.auth_code.get_token(code, :redirect_uri => callback_url)
        end

        def authorize_url
          client.auth_code.authorize_url(
            :scope        => scopes,
            :redirect_uri => callback_url
          )
        end
      end
    end
  end
end
