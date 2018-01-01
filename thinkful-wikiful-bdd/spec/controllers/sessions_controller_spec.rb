require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "log in" do

    context "POST create" do
      it "logs in an existing user and redirects to the root path" do
        post :create, { email: @user.email, password: @user.password }
        expect(request.flash[:notice]).to start_with("Success!")
        expect(response).to redirect_to(root_path)
      end

      it "prohibits an invalid account from logging in" do
        post :create, { email: 'bad@email.com', password: 'bad-password' }
        expect(request.flash.now[:error]).to start_with("Aww, shucks!")
      end
    end
  end

   describe "log out" do

    context "GET destroy" do
      it "prohibits an invalid account from logging in" do
        get :destroy
        expect(request.flash[:notice]).to start_with("You've been logged out!")
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
