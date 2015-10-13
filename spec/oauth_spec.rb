require File.dirname(__FILE__) + '/spec_helper'

describe 'Warden::Oauthed' do
  it 'requesting an url that requires authentication redirects to github' do
    response = get '/'

    uri = Addressable::URI.parse(response.headers['Location'])

    expect(uri.scheme).to eq 'http'
    expect(uri.host).to eq 'localhost'

    params = uri.query_values
    expect(params['response_type']).to eq 'code'
    expect(params['scope']).to eq 'public'
    expect(params['client_id']).to match(/\w{20}/)
    expect(params['redirect_uri']).to eq 'http://example.org/auth/oauthed/callback'
  end
end
