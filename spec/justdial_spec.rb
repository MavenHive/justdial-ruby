require 'spec_helper'

describe 'JustDial client' do
  it 'constructs the correct search object' do
    auth_tokens = {:event_token => 'foo', :token => 'bar'}
    query_params = {:query => 'a query', :city => 'a city'}
    expect(JustDial::Search).to receive(:new).with(auth_tokens, query_params)
    client = JustDial::Client.new(auth_tokens)
    client.search(query_params)
  end
end