require 'rails_helper'

describe "sign up process", type: :feature do

  feature "sign up" do
    scenario "signs me up and logs me in" do
      signup
      expect(page).to have_content 'Success'
    end
  end

  feature "cancel sign up" do
    scenario "cancels the sign up process and redirects me to the home page" do
      visit signup_path
      click_on 'Cancel'
      expect(current_path).to eq(root_path)
    end
  end
end