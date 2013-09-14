require 'restclient'

module JustDial
  class Search
    def initialize(url, auth_tokens={})
      @url = url
      @auth_tokens = auth_tokens
    end

    def execute(params={})
      valid_params = params.select { |key| [:query, :city, :area].include?(key) } # TODO: Implement Hash.slice
      geolocation_params = {geolocation: "#{params[:latitude]},#{params[:longitude]}"}
      request_params = @auth_tokens.merge(valid_params).merge(geolocation_params)
      RestClient.get(@url, request_params)
    end
  end
end
