require 'spec_helper'

describe 'JustDial client' do
  it 'constructs the correct search object' do
    auth_tokens = {:event_token => 'foo', :token => 'bar'}
    query_params = {:query => 'a query', :city => 'a city'}
    mock_search = double('Search')
    expect(JustDial::Search).to receive(:new).with('example.com/foo', auth_tokens).and_return(mock_search)
    expect(mock_search).to receive(:execute).with(query_params)
    client = JustDial::Client.new('example.com/foo', auth_tokens)
    client.search(query_params)
  end
end