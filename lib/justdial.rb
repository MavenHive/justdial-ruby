require 'justdial/version'
require 'justdial/search'
require 'justdial/provider'
require 'justdial/exceptions'

module JustDial
  class Client
    def initialize(url, auth_tokens={})
      @url = url
      @auth_tokens = auth_tokens
    end

    def search(params={})
      search = Search.new(@url, @auth_tokens)
      search.execute(params)
    end
  end
end
