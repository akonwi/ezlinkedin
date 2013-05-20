# Ezlinkedin

A simple way to make calls on Linkedin's API. NOTE: It is not yet completed and does not encompass all of the api at this time. It serves the purpose I made it for but I will continue to develop it.

This is heavily inspired and influenced by the [pengwynn/linkedin](https://github.com/pengwynn/linkedin) gem. I was having issues with his gem though and there is very little documentation for using it so I decided to redo it myself in order to:
 * Make it work for what I needed
 * Add precise and useful documentation
 * contribute a bit more robust ruby wrapper for Linkedin's API

Most of the tests are from pengwynn's gem

## Installation

Add this line to your application's Gemfile:

    gem 'ezlinkedin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ezlinkedin

## Usage

		This is meant to be used alongside omniauth. Obtain access tokens from omniauth authentication and then use them to make api calls.

		require 'ezlinkedin'

		# Create a client
		linkedin = EzLinkedin::Client.new("API KEY", "SECRET KEY", options) # options are the typical OAuth consumer options
		linkedin.authorize("access_token", "access_token_secret") # tokens obtained from omniauth

		Currently, one can post shares, retrieve updates, user profile, and connections.
		
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
