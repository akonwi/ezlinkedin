require 'spec_helper'

describe EzLinkedin::Api do
  before do
    EzLinkedin.default_profile_fields = nil
    client.stub(:consumer).and_return(consumer)
    client.authorize('atoken', 'asecret')
  end

  let(:client){EzLinkedin::Client.new('token', 'secret')}
  let(:consumer){OAuth::Consumer.new('token', 'secret', {:site => 'https://api.linkedin.com'})}

  it "should be able to view the account profile" do
    stub_request(:get, "https://api.linkedin.com/v1/people/~").to_return(:body => "{}")
    client.profile.should be_an_instance_of(EzLinkedin::Mash)
  end

 it "should be able to view public profiles" do
   stub_request(:get, "https://api.linkedin.com/v1/people/id=123").to_return(:body => "{}")
   client.profile(:id => 123).should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to view connections" do
   stub_request(:get, "https://api.linkedin.com/v1/people/~/connections").to_return(:body => "{}")
   client.connections.should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to view network_updates" do
   stub_request(:get, "https://api.linkedin.com/v1/people/~/network/updates").to_return(:body => "{}")
   client.network_updates.should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to view network_updates with options" do
   stub_request(:get, "https://api.linkedin.com/v1/people/~/network/updates?type=SHAR&count=5&scope=self").to_return(:body => "{}")
   client.network_updates(types: [:shar], count: 5, scope: 'self').should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to search with a keyword if given a String" do
   stub_request(:get, "https://api.linkedin.com/v1/people-search?keywords=business").to_return(:body => "{}")
   client.search("business").should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to search with an option" do
   stub_request(:get, "https://api.linkedin.com/v1/people-search?first-name=Javan").to_return(:body => "{}")
   client.search(:first_name => "Javan").should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to search with an option and fetch specific fields" do
   stub_request(:get, "https://api.linkedin.com/v1/people-search:(people:(id,first-name),num-results)?first-name=Javan").to_return(
       :body => "{}")
   client.search(:first_name => "Javan", :people => ["id", "first-name"], :fields => ['num-results']).should be_an_instance_of(EzLinkedin::Mash)
 end

it "should be able to search companies" do
   stub_request(:get, "https://api.linkedin.com/v1/company-search:(companies:(id,name),num-results)?keywords=apple").to_return(
       :body => "{}")
   client.search({:keywords => "apple", :company => ["id", "name"], :fields => ['num-results']}).should be_an_instance_of(EzLinkedin::Mash)
 end

 it "should be able to post a share" do
   stub_request(:post, "https://api.linkedin.com/v1/people/~/shares").to_return(:body => "", :status => 201)
   response = client.post_share({:comment => "Testing, 1, 2, 3"})
   response.body.should == nil
   response.code.should == "201"
 end

 context "Company API" do

   it "should be able to view a company profile" do
     stub_request(:get, "https://api.linkedin.com/v1/companies/1586").to_return(:body => "{}")
     client.company(:id => 1586).should be_an_instance_of(EzLinkedin::Mash)
   end

   it "should be able to view a company by universal name" do
     stub_request(:get, "https://api.linkedin.com/v1/companies/universal-name=acme").to_return(:body => "{}")
     client.company(:name => 'acme').should be_an_instance_of(EzLinkedin::Mash)
   end

   it "should be able to view a company by e-mail domain" do
     stub_request(:get, "https://api.linkedin.com/v1/companies?email-domain=acme.com").to_return(:body => "{}")
     client.company(:domain => 'acme.com').should be_an_instance_of(EzLinkedin::Mash)
   end

 end

 context "Group API" do

   it "should be able to list group memberships for a profile" do
     stub_request(:get, "https://api.linkedin.com/v1/people/~/group-memberships?membership-state=member").to_return(:body => "{}")
     client.group_memberships.should be_an_instance_of(EzLinkedin::Mash)
   end

   it "should be able to get group memberships given an option of fields" do
     stub_request(:get, "https://api.linkedin.com/v1/people/~/group-memberships:(group:(id,name))?membership-state=member").to_return(:body => "{}")
     client.group_memberships(fields: ['id', 'name']).should be_an_instance_of(EzLinkedin::Mash)
   end

   it "should be able to join a group" do
     stub_request(:put, "https://api.linkedin.com/v1/people/~/group-memberships/123").to_return(:body => "", :status => 201)

     response = client.join_group(123)
     response.body.should == nil
     response.code.should == "201"
   end

 end

  context "Errors" do
    it "should raise AccessDeniedError when EzLinkedin returns 403 status code" do
      stub_request(:get, "https://api.linkedin.com/v1/people/~").to_return(:body => "{}", :status => 403)
      expect{ client.profile }.to raise_error(EzLinkedin::Errors::AccessDeniedError)
    end
  end
end
