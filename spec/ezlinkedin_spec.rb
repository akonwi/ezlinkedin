require 'spec_helper'
require 'ezlinkedin'

describe EzLinkedin::Client do
	let(:client) { EzLinkedin::Client.new('api_key', 'secret_key') }

	it "client initializes" do
		client.nil?.should_not be_true
		client.consumer_key.should eql('api_key')
		client.consumer_secret.should eql('secret_key')
		client.client.should be_a_kind_of OAuth::Consumer
 	end

 	it 'creates an access token' do
 		client.authorize('token', 'token_secret')
		access_token = client.access_token
		access_token.should be_a_kind_of OAuth::AccessToken
 end

end
