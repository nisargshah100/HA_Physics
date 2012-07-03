require 'spec_helper'

describe UserDetail do
  describe "#location" do
    let(:user_detail) { UserDetail.new(city: "Washington", state: "DC") }
    it "should return a well formatted string" do
      user_detail.location.should == "Washington, DC"
    end
  
    context "if either city or state is missing" do
      it "should return nil" do
        user_detail.city = nil
        user_detail.location.should == nil
      end
    end
  end

  describe "#gender_orientation_array" do
    let(:user_detail) { UserDetail.new(gender: "male", gender_preference: "women") }
    it "should return an array with both the gender and the preference" do
      user_detail.gender_orientation_array.should == [user_detail.gender, user_detail.gender_preference]
    end
  end

  describe "#get_gender_orientation" do
    let(:user_detail) { UserDetail.new(gender: "male", gender_preference: "women") }
    it "should return a string classifying gender orientation (e.g. what a different user would be looking for)" do
      user_detail.get_gender_orientation.should == "straight guys"
    end
  end

  describe "#orientation" do
    context "given you prefer the opposite gender class" do
      let(:user_detail) { UserDetail.new(gender: "male", gender_preference: "women" ) }
      
      it "should return stright" do
        user_detail.orientation.should =~ /straight/i
      end
    end

    context "given you prefer the same gender class" do
      let(:user_detail) { UserDetail.new(gender: "female", gender_preference: "women" ) }
      
      it "should return gay" do
        user_detail.orientation.should =~ /gay/i
      end
    end

    context "given you prefer both gender classes" do
      let(:user_detail) { UserDetail.new(gender: "female", gender_preference: "both" ) }
      
      it "should return bisexual" do
        user_detail.orientation.should =~ /bisexual/i
      end
    end
  end

  describe "#objective_pronoun" do
    context "if you are a male" do
      it "should return the string him" do
        user_detail = UserDetail.new(gender: "male")
        user_detail.objective_pronoun.should == "him"
      end
    end

    context "if you are a female" do
      it "should return the string her" do
        user_detail = UserDetail.new(gender: "female")
        user_detail.objective_pronoun.should == "her"
      end
    end
  end

  describe "#image" do
    context "given you have an image" do
      let(:user_detail) { UserDetail.new(image: "me.jpg") }

      pending "should return your image" do
        user_detail.image.should == "me.jpg"
      end
    end

    context "given the image is nil" do
      context "and you are a female" do
        let(:user_detail) { UserDetail.new(gender: "female") }

        it "should return the default" do
          user_detail.image.should == "/assets/default_female_250.png"
        end
      end

      context "and you are a male" do
        let(:user_detail) { UserDetail.new(gender: "male") }

        it "should return the default" do
          user_detail.image.should == "/assets/default_male_250.png"
        end
      end
    end
  end
end