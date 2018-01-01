  require 'rails_helper'

  describe "log in process", type: :feature do
    let!(:user) { FactoryGirl.create(:user) }

    feature "logi n" do
      scenario "logs me in and redirects me to the home page" do
        login user
        expect(page).to have_content('Success!')
        expect(current_path).to eq root_path
      end
    end

    feature "log out" do
      scenario "logs me out and redirects me to the home page" do
        login user
        expect(page).to have_content('Success!')
        expect(current_path).to eq root_path
        logout
        expect(page).to have_content("You've been logged out!")
        expect(current_path).to eq root_path
      end
    end

    feature "cancel log in" do
      scenario "cancels the log in process and redirects me to the home page" do
        visit login_path
        click_on 'Cancel'
        expect(current_path).to eq(root_path)
      end
    end
  end