require 'spec_helper'

describe 'Search' do
  describe 'execute' do
    let(:api_url) { 'http://example.com/foo' }
    let(:auth_tokens) { {event_token: 'an_event_token', token: 'a_request_token'} }
    let(:search) { JustDial::Search.new(api_url, auth_tokens) }
    let(:stub_response) { RestClient::RawResponse.new(nil, nil, nil) }

    it 'makes request to the correct endpoint with the provided parameters' do
      search_parameters = {query: 'car hire',
                           city: 'bangalore',
                           area: 'jayanagar',
                           latitude: '12.9667',
                           longitude: '77.5667',
                           num_res: 100}

      expected_request_params = auth_tokens.merge({q: 'car hire',
                                                   city: 'bangalore',
                                                   area: 'jayanagar',
                                                   geolocation: '12.9667,77.5667',
                                                   num_res: 100})

      allow(stub_response).to receive(:code).and_return(200)
      allow(stub_response).to receive(:to_s).and_return("{}")
      expect(RestClient).to receive(:get).with(api_url, {params: expected_request_params}).and_return(stub_response)

      search.execute(search_parameters)
    end

    describe 'Exceptions' do
      it 'raises QuotaExceeded for HTTP 306' do
        expect(stub_response).to receive(:code).and_return(306)
        allow(RestClient).to receive(:get).and_return(stub_response)
        expect { search.execute({}) }.to raise_error(JustDial::QuotaExceeded)
      end

      it 'raises QuotaExceeded for HTTP 400' do
        expect(stub_response).to receive(:code).and_return(400)
        allow(RestClient).to receive(:get).and_return(stub_response)
        expect { search.execute({}) }.to raise_error(JustDial::MissingParameters)
      end

      it 'raises QuotaExceeded for HTTP 401' do
        expect(stub_response).to receive(:code).and_return(401)
        allow(RestClient).to receive(:get).and_return(stub_response)
        expect { search.execute({}) }.to raise_error(JustDial::Unauthorized)
      end

      it 'raises QuotaExceeded for HTTP 405' do
        expect(stub_response).to receive(:code).and_return(405)
        allow(RestClient).to receive(:get).and_return(stub_response)
        expect { search.execute({}) }.to raise_error(JustDial::MethodNotAllowed)
      end
    end
  end
end
