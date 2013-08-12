# Ezlinkedin

A simple way to make calls on Linkedin's API. NOTE: It is not yet completed and does not encompass all of the api at this time. It serves the purpose I made it for but I will continue to develop it.

This is heavily inspired and influenced by the [pengwynn/linkedin](https://github.com/pengwynn/linkedin) gem. I was having issues with his gem though and there is very little documentation for using it so I decided to redo it myself in order to:
 * Make it work for what I needed
 * Add precise and useful documentation
 * learn the api

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

```ruby
require 'ezlinkedin'

# Create a client
linkedin = EzLinkedin::Client.new("API KEY", "SECRET KEY", options) # options are the typical OAuth consumer options
linkedin.authorize("access_token", "access_token_secret") # tokens obtained from omniauth

# make calls on linkedin
linkedin.profile(id: 1234, fields: ['name', 'email']
linkedin.connections(count: 30)
linkedin.network_updates(types: [:shar, :prfx, :conn], count: 50)
linkedin.post_share({:comment => "I'm a comment",
	             :content => { :title => "A title!",
	                           :description => "A description",
	                           :submitted_url => "http...",
	                           :submitted_image_url => "http..." },
	             :visibility => { :code => "anyone"} })
linkedin.search(company: ['id', 'name'], keywords: 'apple')
linkedin.search(people: ['first-name', 'id'], last_name: 'johnson')
```

Currently, one can:
	* post shares
	* retrieve network updates, user profile, and connections
	* search for companies and people
	* use the company and people search api

## TODO

I'd really like to include the facets capabilities in the search because it would really boost search efficiency.

This gem fits the purposes I had for it and I'm satisfied. Besides implementing Faceted search, I don't plan on implementing other features at this point. But feel free to contribute

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
