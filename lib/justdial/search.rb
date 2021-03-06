require 'restclient'

module JustDial
  class Search
    def initialize(url, auth_tokens={})
      @url = url
      @auth_tokens = auth_tokens
    end

    def execute(params={})
      valid_params = params.select { |key| [:city, :area].include?(key) } # TODO: Implement Hash.slice
      latitude = params[:latitude]
      longitude = params[:longitude]
      page_size = params[:num_res] || 100
      request_params = {}
      request_params = request_params.merge(@auth_tokens).merge(valid_params)
      request_params[:q] = params[:query]
      request_params[:geolocation] = "#{latitude},#{longitude}" if !latitude.nil? && !longitude.nil?
      request_params[:num_res] = page_size
      puts "Request: url: #{@url} params: #{request_params}"

      error = nil
      begin
        response = RestClient.get(@url, {:params => request_params, })
      rescue RestClient::Exception => e
        response = e.response
        error = e
      end

      puts "Response: #{response.code}, #{response.to_s}"

      case response.code
        when 200
          Provider.parse(response.to_s)
        when 306
          raise JustDial::QuotaExceeded
        when 400
          raise JustDial::MissingParameters
        when 401
          raise JustDial::Unauthorized
        when 405
          raise JustDial::MethodNotAllowed
        else
          raise error if !error.nil?
      end
    end
  end
end
