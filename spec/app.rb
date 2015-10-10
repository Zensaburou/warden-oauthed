require 'sinatra'

module Example
  class App < Sinatra::Base
    enable  :sessions
    enable  :raise_errors
    disable :show_exceptions

    use Warden::Manager do |manager|
      manager.default_strategies :oauthed
      manager.failure_app = BadAuthentication
      manager[:oauthed_client_id]    = ENV['APPLICATION_CLIENT_ID']
      manager[:oauthed_secret]       = ENV['APPLICATION_CLIENT_SECRET']
      manager[:oauthed_scopes]       = ENV['APPLICATION_SCOPES_REQUESTED']
      manager[:oauthed_oauth_domain] = ENV['OAUTH_BASE_URL']
      manager[:oauthed_callback_url] = '/auth/oauthed/callback'
    end

    helpers do
      def ensure_authenticated
        unless env['warden'].authenticate!
          throw(:warden)
        end
      end

      def user
        env['warden'].user
      end
    end

    get '/' do
      ensure_authenticated
      "Hello There,\n<pre>#{user.token}</pre>"
    end

    get '/redirect_to' do
      ensure_authenticated
      "Hello There, #{user.name}! return_to is working!"
    end

    get '/auth/oauthed/callback' do
      ensure_authenticated
      redirect '/'
    end

    get '/logout' do
      env['warden'].logout
      "Peace!"
    end
  end

  class BadAuthentication < Sinatra::Base
    get '/unauthenticated' do
      status 403
      "Unable to authenticate, sorry bud."
    end
  end

  def self.app
    @app ||= Rack::Builder.new do
      run App
    end
  end
end
