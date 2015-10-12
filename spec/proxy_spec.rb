require File.dirname(__FILE__) + '/spec_helper'

describe 'Warden::Oauthed::Oauth::Proxy' do
  before(:all) do
    sha = Digest::SHA1.hexdigest(Time.now.to_s)
    @proxy =  Warden::Oauthed::Oauth::Proxy.new(sha[0..19], sha[0..39],
      'public',
      'http://localhost:3000',
      'http://example.org/auth/oauthed/callback')
  end

  it 'returns an authorize url' do
    uri = Addressable::URI.parse(@proxy.authorize_url)

    uri.scheme.should eql('http')
    uri.host.should eql('localhost')

    params = uri.query_values
    expect(params['response_type']).to eq 'code'
    expect(params['scope']).to eq 'public'
    expect(params['client_id']).to match(/\w{20}/)
    expect(params['redirect_uri']).to eq 'http://example.org/auth/oauthed/callback'
  end

  it "has a client object" do
    expect(@proxy).not_to be nil
  end

  # it "returns access tokens" do
  #  lambda { @proxy.access_token_for(/\w{20}/.gen) }.should_not raise_error  
  # end
end
