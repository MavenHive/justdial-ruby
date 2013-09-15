require 'restclient'

module JustDial
  class Search
    def initialize(url, auth_tokens={})
      @url = url
      @auth_tokens = auth_tokens
    end

    def execute(params={})
      valid_params = params.select { |key| [:query, :city, :area].include?(key) } # TODO: Implement Hash.slice
      latitude = params[:latitude]
      longitude = params[:longitude]
      geolocation_params = {}
      geolocation_params[:geolocation] = "#{latitude},#{longitude}" if !latitude.nil? && !longitude.nil?
      page_size = params[:num_res] || 100
      request_params = @auth_tokens.merge(valid_params).merge(geolocation_params).merge({:num_res => page_size})
      error = nil
      begin
        response = RestClient.get(@url, {:params => request_params, })
      rescue RestClient::Exception => e
        response = e.response
        error = e
      end

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
