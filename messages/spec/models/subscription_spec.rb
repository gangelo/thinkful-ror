require 'rails_helper'

RSpec.describe Subscription, :type => :model do

  before(:each) do
    @zach = User.create!
    @zach.subscription = Subscription.new

    @david = User.create!
    @david.subscription = Subscription.new
  end

  describe "#can_send_message?" do
    
    context "when a user has not reached the subscription limit for the month" do
      it "returns true" do
        #
        # Note: stub the subscription_limit_reached? method, we'll test this method
        # in isolation.
        allow(@zach.subscription).to receive_messages(subscription_limit_reached?: false)
        expect(@zach.subscription.can_send_message?).to be(true)
        expect(@zach.subscription).to have_received(:subscription_limit_reached?).once
      end
    end

    context "when a user has reached the subscription limit for the month" do 
      it "returns false" do
        #
        # Note: stub the subscription_limit_reached? method, we'll test this method
        # in isolation.
        allow(@zach.subscription).to receive_messages(subscription_limit_reached?: true)
        expect(@zach.subscription.can_send_message?).to be(false)
        expect(@zach.subscription).to have_received(:subscription_limit_reached?).once
      end
    end
  end

  describe "#messages_sent_this_month" do
    
    before(:each) do
      @now = DateTime.now
    end

    it "should return 0 if the user has sent no messages sent month" do
      expect(@zach.subscription.send(:messages_sent_this_month)).to eq(0)
    end

    it "should return the correct count of the user messages sent this month" do
      #
      # Add some messages sent this month...
      10.times { 
        @zach.send_message(
          title: 'Book Update', 
          text: 'Beta 11 includes great stuff!', 
          recipient: @david,
          created_at: @now
        )     
      }
      expect(@zach.subscription.send(:messages_sent_this_month)).to eq(10)
    end
  end

  describe "#subscription_limit_reached?" do
   
    context "when a user has not reached the subscription limit for the month" do
      it "returns false" do
        allow(@zach.subscription).to receive_messages(subscription_limit: 10)
        expect(@zach.subscription.subscription_limit_reached?).to be(false)
      end
    end

    context "when a user has reached the subscription limit for the month" do
      it "returns true" do
        allow(@zach.subscription).to receive_messages(subscription_limit: 10)
        10.times { 
          @zach.send_message(
            title: 'Book Update', 
            text: 'Beta 11 includes great stuff!', 
            recipient: @david
          )     
        }
        expect(@zach.subscription.subscription_limit_reached?).to be(true)
      end
    end
  end
end
