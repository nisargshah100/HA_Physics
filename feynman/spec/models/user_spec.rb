require 'spec_helper'
require 'hashie'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context "#ensure_authentication_token" do
    it "should be called upon save" do
      user.should_receive(:ensure_authentication_token)
      user.save
    end
  end

  context ".find_for_facebook_oauth" do
    let(:auth) { Hashie::Mash.new({ provider: "facebook", uid: "1" }) }

    describe "If a facebook user does not exist" do
      it "should create a user" do
        User.should_receive(:create_user_with_detail).with(auth)
        User.find_for_facebook_oauth(auth)
      end
    end

    describe "If a facebook user already exists" do
      let(:user) { User.new }

      it "returns the found user" do
        User.stub(:where).with({ provider: "facebook", uid: "1" }).and_return([user])
        User.find_for_facebook_oauth(auth).should == user
      end

      it "it does not create a new user" do
        User.should_receive(:where).with({ provider: "facebook", uid: "1" }).and_return([user])
        User.should_not_receive(:create_user_with_detail)
        User.find_for_facebook_oauth(auth).should
      end
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  authentication_token   :string(255)
#  private                :boolean         default(FALSE)
#