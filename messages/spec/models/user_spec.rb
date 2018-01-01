require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "#send_message" do
    before(:each) do
      @zach = User.create!
      @zach.subscription = Subscription.new

      @david = User.create!
    end
    
    context "when the user is under their subscription limit" do 
      before(:each) do
        #
        # Old rspec-mocks stub syntax.
        # @zach.subscription.stub(:can_send_message?).and_return true
 
        #       
        # New rspec-mocks stub syntax.
        allow(@zach.subscription).to receive_messages(can_send_message?: true)
      end

      it "sends a message to another user" do
        msg = @zach.send_message(
          title: 'Book Update', 
          text: 'Beta 11 includes great stuff!', 
          recipient: @david
        )        
        #
        # Using xxx.to eq([msg]) not xxx.to equal([msg])
        # as we're not interested in object equality, but
        # only the equality of values.
        expect(@david.received_messages).to eq([msg])  
      end

      it "creates a new message with the submitted attributes" do 
        msg = @zach.send_message(
          title: 'Book Update',
          text: 'Beta 11 includes great stuff!', 
          recipient: @david
        )
        expect(msg.title).to eq('Book Update')
        expect(msg.text).to eq('Beta 11 includes great stuff!')
      end

      it "adds the message to the sender's sent messages" do
        msg = @zach.send_message(
          title: 'Book Update', 
          text: 'Beta 11 includes great stuff!', 
          recipient: @david
        )
        #
        # Using xxx.to eq([msg]) not xxx.to equal([msg])
        # as we're not interested in object equality, but
        # only the equality of values.
        expect(@zach.sent_messages).to eq([msg])
      end
    end

    context "when the user is over their subscription limit" do 
      before(:each) do
        #
        # Old rspec-mocks stub syntax.
        # @zach.subscription.stub(:can_send_message?).and_return false
 
        #       
        # New rspec-mocks stub syntax.
        allow(@zach.subscription).to receive_messages(can_send_message?: false)
      end

      it "does not create a message" do
        expect(
          lambda {
            @zach.send_message(
              title: 'Book Update',
              text: 'Beta 11 includes great stuff!', 
              recipient: @david
            )
          }
        ).not_to change(Message, :count)
      end 
    end

  end
end
