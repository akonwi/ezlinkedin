# Ezlinkedin

A simple way to make calls on Linkedin's API

## Installation

Add this line to your application's Gemfile:

    gem 'ezlinkedin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ezlinkedin

## Usage

		require 'ezlinkedin'

		# Create a client
		linkedin = EzLinkedin::Client.new("API KEY", "SECRET KEY", options)
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
