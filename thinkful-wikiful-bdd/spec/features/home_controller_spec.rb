require 'rails_helper'

describe "home page", type: :feature do

  it "renders successfully" do
    visit root_path
    expect(page.status_code).to be 200
  end
end 