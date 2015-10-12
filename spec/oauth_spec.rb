require File.dirname(__FILE__) + '/spec_helper'

describe 'Warden::Oauthed' do
  it 'requesting an url that requires authentication redirects to github' do
    ENV['OAUTH_BASE_URL'] = 'http://localhost:3000'
    ENV['APPLICATION_SCOPES_REQUESTED'] = 'public'
    ENV['APPLICATION_CLIENT_ID'] = 'fd6df6f74658a9202d401aaba38223a7f79e7572926ce845e5268f5171e5b2d5'
    ENV['APPLICATION_CLIENT_SECRET'] = 'afee0e20322e5d73dff82f29baf5989afd3422557056129aad29d974e56df677'
    response = get '/'

    uri = Addressable::URI.parse(response.headers['Location'])

    expect(uri.scheme).to eq 'http'
    expect(uri.host).to eq 'localhost'

    params = uri.query_values
    expect(params['response_type']).to eq 'code'
    expect(params['scope']).to eq 'public'
    expect(params['client_id']).to match /\w{20}/
    expect(params['redirect_uri']).to eq 'http://example.org/auth/oauthed/callback'
  end
end
