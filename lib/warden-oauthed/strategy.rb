Warden::Strategies.add(:oauthed) do
  # Need to make sure that we have a pure representation of the query string.
  # Rails adds an "action" parameter which causes the openid gem to error
  def params
    @params ||= Rack::Utils.parse_query(request.query_string)
  end

  def api_url
    ENV['API_BASE_URL'] || '/api/v1'
  end

  def authenticate!
    if params['code']
      begin
        get_user_api_response(params)
      rescue OAuth2::Error
        %(<p>Outdated ?code=#{params['code']}:</p><p>#{$ERROR_INFO}</p>
          <p><a href="/auth/oauthed">Retry</a></p>)
      end
    else
      env['rack.session']['return_to'] = env['REQUEST_URI']
      throw(:warden, [302, { 'Location' => authorize_url }, []])
    end
  end

  private

  def get_user_api_response(params)
    api = api_for(params['code'])
    resp = api.get "#{api_url}/me" do |request|
      request.params['access_token'] = api.token
    end.body

    user = MultiJson.load(resp)
    success!(Warden::Oauthed::Oauth::User.new(user['user'], api.token))
  end

  def oauth_client
    oauth_proxy.client
  end

  def authorize_url
    oauth_proxy.authorize_url
  end

  def api_for(code)
    oauth_proxy.api_for(code)
  end

  def oauth_proxy
    @oauth_proxy ||= Warden::Oauthed::Oauth::Proxy.new(
      env['warden'].config[:oauthed_client_id],
      env['warden'].config[:oauthed_secret],
      env['warden'].config[:oauthed_scopes],
      env['warden'].config[:oauthed_oauth_domain],
      callback_url
    )
  end

  def callback_url
    absolute_url(
      request,
      env['warden'].config[:oauthed_callback_url],
      env['HTTP_X_FORWARDED_PROTO']
    )
  end

  def absolute_url(request, suffix = nil, proto = 'http')
    port_part =
      case request.scheme
      when 'http'
        request.port == 80 ? '' : ":#{request.port}"
      when 'https'
        request.port == 443 ? '' : ":#{request.port}"
      end
    proto = 'http' if proto.nil?
    "#{proto}://#{request.host}#{port_part}#{suffix}"
  end
end
