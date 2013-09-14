require 'json'

module JustDial
  class Provider
    def initialize(options={})
      options.each { |attribute, value|
        self.class.send('attr_accessor', attribute)
        self.send("#{attribute}=", value)
      }
    end

    def self.parse(json)
      results = []
      providers = JSON.parse(json)
      providers.each { |id, content|
        results << Provider.new({id: id}.merge(content))
      }
      results
    end
  end
end
