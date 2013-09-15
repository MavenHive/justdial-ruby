module JustDial
  class Error < RuntimeError
  end

  class Unauthorized < Error
    def initialize
      super('Invalid Auth Tokens')
    end
  end

  class MissingParameters < Error
    def initialize
      super('Missing mandatory search parameters (query, city)')
    end
  end

  class QuotaExceeded < Error
    def initialize
      super('Request Quota Exceeded')
    end
  end

  class MethodNotAllowed < Error
    def initialize
      super('Invalid HTTP method used')
    end
  end
end
