require 'spec_helper'

describe 'Signing up from the home page' do
  let(:user) { FactoryGirl.build(:user) }
  let(:user_details) { FactoryGirl.build(:user_details) }

  describe "When viewing the root" do
    before(:each) { visit "http://feynman.dev" }

    it "then I should see a button to sign up" do
      page.should have_selector("#signup_btn")
    end

    describe "When I click the button" do
      before(:each) { find("#signup_btn").click }
      
      it "should take me to preferences form" do
        page.should have_selector("#user_detail_gender")
        page.should have_selector("#user_detail_gender_preference")
        page.should have_selector("#user_detail_zipcode")
      end

      describe "When I fill out the preference information and click continue" do
        before(:each) do
          select  "male",    from: "user_detail_gender"
          select  "women",   from: "user_detail_gender_preference"
          fill_in "user_detail_zipcode", with: "20036"
          find("#signup_continue").click
        end

        it "should take me to a user account information form" do
          page.should have_content("Birthday")
          page.should have_selector("#user_email")
          page.should have_selector("#user_password")
        end

        describe "When I fill out the account information and click continue" do
          before(:each) do
            select  "June",    from: "user_birthday_2i"
            select  "21",      from: "user_birthday_3i"
            select  "1988",      from: "user_birthday_1i"
            fill_in "user_display_name", with: "edweng"
            fill_in "user_email", with: "edweng@gmail.com"
            fill_in "user_password", with: "hungry"
            find("#signup_continue").click
          end

          it "should take me to my profile" do
            page.should have_content("edweng")
          end
        end
      end
    end
  end
end