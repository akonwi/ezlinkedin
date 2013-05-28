require "ezlinkedin/version"
require 'ezlinkedin/request'
require 'ezlinkedin/api'
require 'ezlinkedin/mash'
require 'ezlinkedin/client'
require 'ezlinkedin/errors'
require 'oauth'
require 'open-uri'

module EzLinkedin
  class << self
    attr_accessor :token, :secret, :default_profile_fields

    # EzLinkedin.configure do |config|
    #   config.token = 'consumer_token'
    #   config.secret = 'consumer_secret'
    #   config.default_profile_fields = ['education', 'positions']
    # end
    #
    # elsewhere
    #
    # client = EzLinkedin::Client.new
    def configure
      yield self
      true
    end
  end
end
