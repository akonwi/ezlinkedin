require "cgi"

module EzLinkedin
	class Client
		include Request
		include Api::QueryMethods
		include Api::UpdateMethods

		attr_reader :consumer_key, :consumer_secret, :access_token, :client
		attr_accessor :consumer_options

		def initialize(c_key=EzLinkedin.token, c_secret=EzLinkedin.secret, options={})
			@consumer_key = c_key
			@consumer_secret = c_secret
			@consumer_options = { site: 'https://api.linkedin.com',
														request_token_path: '/uas/oauth/requestToken',
  													access_token_path: '/uas/oauth/accessToken',
  													authorize_path: '/uas/oauth/authorize' }
			@consumer_options.merge(options)
			@client = OAuth::Consumer.new(c_key, c_secret, @consumer_options)
		end

		# Create and outh access token to make api calls with
		# param: token - the access token obtained from omniauth
		# param: token_secret - the access token secret obtained from omniauth
		def authorize(token, token_secret)
			@access_token = OAuth::AccessToken.new(@client, token, token_secret)
		end

	end
end
