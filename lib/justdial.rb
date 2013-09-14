require 'justdial/version'
require 'justdial/search'

module JustDial
  class Client
    def initialize(auth_tokens={})
      @auth_tokens = auth_tokens
    end

    def search(params={})
      Search.new(@auth_tokens, params)
    end
  end
end
