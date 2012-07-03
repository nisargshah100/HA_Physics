require 'spec_helper'

describe UserDetail do
  let!(:straight_male_user)   { FactoryGirl.create(:straight_male_user) }
  let!(:bisexual_male_user)   { FactoryGirl.create(:bisexual_male_user) }
  let!(:gay_male_user)        { FactoryGirl.create(:gay_male_user) }
  let!(:straight_female_user) { FactoryGirl.create(:straight_female_user) }
  let!(:bisexual_female_user) { FactoryGirl.create(:bisexual_female_user) }
  let!(:gay_female_user)      { FactoryGirl.create(:gay_female_user) }

  describe "#compatible_user_details" do
    context "given a straight male user" do
      it "Should return all straight female users" do
        straight_male_user.compatible_user_details.should include(straight_female_user.user_detail)
      end

      it "Should return all bisexual female users" do
        straight_male_user.compatible_user_details.should include(bisexual_female_user.user_detail)
      end
    end

    context "given a gay male user" do
      it "Should return all gay male users" do
        gay_male_user.compatible_user_details.should include(gay_male_user.user_detail)
      end

      it "Should return all bisexual male users" do
        gay_male_user.compatible_user_details.should include(bisexual_male_user.user_detail)
      end
    end

    context "given a bisexual male user" do
      it "Should return all gay male users" do
        bisexual_male_user.compatible_user_details.should include(gay_male_user.user_detail)
      end

      it "Should return all bisexual female users" do
        bisexual_male_user.compatible_user_details.should include(bisexual_female_user.user_detail)
      end

      it "Should return all straight female users" do
        bisexual_male_user.compatible_user_details.should include(straight_female_user.user_detail)
      end

      it "Should return all bisexual male users" do
        bisexual_female_user.compatible_user_details.should include(bisexual_male_user.user_detail)
      end
    end

    context "given a straight female user" do
      it "Should return all straight male users" do
        straight_female_user.compatible_user_details.should include(straight_male_user.user_detail)
      end

      it "Should return all bisexual male users" do
        straight_female_user.compatible_user_details.should include(bisexual_male_user.user_detail)
      end
    end

    context "given a gay female user" do
      it "Should return all gay female users" do
        gay_female_user.compatible_user_details.should include(gay_female_user.user_detail)
      end

      it "Should return all bisexual female users" do
        gay_female_user.compatible_user_details.should include(bisexual_female_user.user_detail)
      end
    end

    context "given a bisexual female user" do
      it "Should return all gay female users" do
        bisexual_female_user.compatible_user_details.should include(gay_female_user.user_detail)
      end

      it "Should return all bisexual female users" do
        bisexual_female_user.compatible_user_details.should include(bisexual_female_user.user_detail)
      end

      it "Should return all straight male users" do
        bisexual_female_user.compatible_user_details.should include(straight_male_user.user_detail)
      end

      it "Should return all bisexual male users" do
        bisexual_female_user.compatible_user_details.should include(bisexual_male_user.user_detail)
      end
    end
  end
end