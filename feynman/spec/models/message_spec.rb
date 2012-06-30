require 'spec_helper'

describe Message do
  describe "#mark_as_opened" do
    it "should change the messages status to 'read'" do
      message = Message.new()
      message.should_receive(:update_attribute).with(:status, "read")
      message.mark_as_opened
    end
  end

  describe "#pretty_time" do
    it "should change the created_at date/time to a well formatted string" do
      message = Message.new
      message.stub(:created_at) { DateTime.parse("2012-06-30T12:28:35-04:00") }
      message.pretty_time.should == "Sat, Jun 30 at 12:28 PM"
    end
  end

  describe ".by_persons" do
    Message.create()

    context "given a hash of attributes that exist on the message" do
      it "should try to search by these attributes" do
        Message.should_receive(:where).with(recipient_id: '5')

        Message.by_persons({ recipient_id: '5' })
      end
    end
  end
end
