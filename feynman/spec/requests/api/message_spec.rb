require 'spec_helper'

describe 'Messages API', :type => :api do
  context "Fetching all messages through the API" do
    describe "When valid parameters are passed in" do
      let!(:sender) do
        FactoryGirl.create(:straight_male_user) do |user|
          FactoryGirl.create(:message, recipient: user)
        end
      end

      let!(:recipient) do
        FactoryGirl.create(:straight_female_user) do |user|
          FactoryGirl.create(:message, recipient: user, sender: sender)
        end
      end

      it "should return all messages for that recipient" do
        get "#{api_v1_messages_url}.json", token: recipient.authentication_token
        JSON.parse(response.body).count.should == recipient.messages.count
      end

      it "should return a successful response" do
        get "#{api_v1_events_url}.json", token: recipient.authentication_token
        response.status.should == 200
      end
    end
  end

  context "Creating a message through the API" do
    describe "When valid parameters are passed in" do
      let!(:sender) do
        FactoryGirl.create(:straight_male_user) do |user|
          FactoryGirl.create(:message, recipient: user)
        end
      end

      let!(:recipient) do
        FactoryGirl.create(:straight_female_user) do |user|
          FactoryGirl.create(:message, recipient: user, sender: sender)
        end
      end

      it "should return all messages for that recipient" do
        expect{ 
          post "#{api_v1_messages_url}.json", token: sender.authentication_token, message: {recipient_id: recipient.id, body: "hi"} 
        }.to change{ recipient.messages.count }.by(1)
      end

      it "should return a successful response" do
        post "#{api_v1_messages_url}.json", token: sender.authentication_token, message: {recipient_id: recipient.id, body: "hi"} 
        response.status.should == 201
      end
    end
  end
end