# Justdial::Ruby

DISCLAIMER: This gem was created as part of our hack at Bangalore::Hack 2013 and therefore, is not production ready yet and we may or may not maintain it in future. So, use at your own risk.

Ruby Client for JustDial API

## Installation

Add this line to your application's Gemfile:

    gem 'justdial-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install justdial-ruby

## Usage

    require 'justdial'
    client = JustDial::Client.new('http://hack2013.justdial.com/index.php', {event_token: 'event-token', token: 'request-token'})
    client.search(query: 'plumber', city: 'bangalore')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
