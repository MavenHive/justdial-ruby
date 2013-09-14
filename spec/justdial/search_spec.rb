require 'spec_helper'

describe 'Search' do
  describe 'execute' do
    it 'makes request to the correct endpoint with the provided parameters' do
      api_url = 'http://example.com/foo'
      auth_tokens = {event_token: 'an_event_token', token: 'a_request_token'}
      search_parameters = {query: 'car hire', city: 'bangalore',
                           area: 'jayanagar'}
      location_parameters = {latitude: '12.9667', longitude: '77.5667'}
      expect(RestClient).to receive(:get).with(api_url, auth_tokens.merge(search_parameters).merge({geolocation: '12.9667,77.5667'}))
      search = JustDial::Search.new(api_url, auth_tokens)
      search.execute(search_parameters.merge(location_parameters))
    end
  end
end
