require 'spec_helper'

describe Image do
  describe "#small_image_url" do
    context "Given an instagram image url" do
      let(:image) {Image.new(:image_url => "http://distilleryimage7.s3.amazonaws.com/2943b926be5d11e1b2fe1231380205bf_6.jpg")}
      let(:small_image_url) {"http://distilleryimage7.s3.amazonaws.com/2943b926be5d11e1b2fe1231380205bf_5.jpg"}

      it "should return the url for a small image" do
        image.small_image_url.should == small_image_url
      end
    end
  end

  describe "#small_image_url" do
    context "Given an instagram image url" do
      let(:image) {Image.new(:image_url => "http://distilleryimage7.s3.amazonaws.com/2943b926be5d11e1b2fe1231380205bf_6.jpg")}
      let(:large_image_url) {"http://distilleryimage7.s3.amazonaws.com/2943b926be5d11e1b2fe1231380205bf_7.jpg"}

      it "should return the url for a small image" do
        image.large_image_url.should == large_image_url
      end
    end
  end
end
