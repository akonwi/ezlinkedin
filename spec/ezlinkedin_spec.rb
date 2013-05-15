require 'spec_helper'
require 'ezlinkedin'

describe EzLinkedin do
	before(:each) do
    EzLinkedin.token = nil
    EzLinkedin.secret = nil
    EzLinkedin.default_profile_fields = nil
  end

  it "should be able to set the consumer token and consumer secret" do
    EzLinkedin.token  = 'consumer_token'
    EzLinkedin.secret = 'consumer_secret'

    EzLinkedin.token.should  == 'consumer_token'
    EzLinkedin.secret.should == 'consumer_secret'
  end

  it "should be able to set the default profile fields" do
    EzLinkedin.default_profile_fields = ['education', 'positions']

    EzLinkedin.default_profile_fields.should == ['education', 'positions']
  end

  it "should be able to set the consumer token and consumer secret via a configure block" do
    EzLinkedin.configure do |config|
      config.token  = 'consumer_token'
      config.secret = 'consumer_secret'
      config.default_profile_fields = ['education', 'positions']
    end

    EzLinkedin.token.should  == 'consumer_token'
    EzLinkedin.secret.should == 'consumer_secret'
    EzLinkedin.default_profile_fields.should == ['education', 'positions']
  end

end
