require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe "POST create" do
=begin
    Use let to define a memoized helper method. The value will be cached
    across multiple calls in the same example but not across examples.

    Note that let is lazy-evaluated: it is not evaluated until the first time
    the method it defines is invoked. You can use let! to force the method's
    invocation before each example.

    as_null_object:

    Use the as_null_object method to ignore any messages that aren't explicitly
    set as stubs or message expectations.

    EXCEPTION: to_ary will raise a NoMethodError unless explicitly stubbed in
    order to support flatten on an Array containing a double.
=end
    let(:message) { mock_model(Message).as_null_object }

    before do
      # Stub.
      # https://github.com/rspec/rspec-mocks
      # https://relishapp.com/rspec/rspec-mocks/v/3-0/docs/
      #
      allow(Message).to receive(:new).and_return(message)
    end

    it "creates a new message" do
      # Message expectation.
      #
      expect(Message).to receive(:new).with("text" => "a quick brown fox").and_return(message)
      post :create, :message => { "text" => "a quick brown fox" }
    end

    context "when the message saves successfully" do
      before do
        allow(message).to receive(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post :create
        expect(flash[:notice]).to eq("The message was saved successfully.")
      end

      it "redirects to the Messages index" do
        post :create
        expect(response).to redirect_to(action: :index)
      end
    end

    context "when the message fails to save" do
      before do
        allow(message).to receive(:save).and_return(false)
      end

      it "assigns @message" do
        allow(message).to receive(:save).and_return(false)
        post :create
        expect(assigns[:message]).to eq(message)
      end

      it "renders the new template" do
        allow(message).to receive(:save).and_return(false)
        post :create
        expect(response).to render_template(:new)
      end
    end

  end
end
