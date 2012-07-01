require 'spec_helper'

describe UserDetail do
  describe "#complete?" do
    let(:user_detail) { UserDetail.new(zipcode: "20036", gender: "male", gender_preference: "female") }
    
    context "if a user detail has a zip code, a gender, and a gender preference" do
      it "should return true" do
        user_detail.complete?.should == true
      end
    end

    context "if it doesn't have a zip code, a gender, and a gender preference" do
      it "should return false" do
        user_detail.gender = nil
        user_detail.complete?.should == false
      end
    end
  end

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

  describe "#ensure_valid_country" do
    context "given the user is located in the USA" do
      it "should return true" do
        user_detail = UserDetail.new(country: "USA")
        user_detail.ensure_valid_country.should == true
      end
    end
  end


end