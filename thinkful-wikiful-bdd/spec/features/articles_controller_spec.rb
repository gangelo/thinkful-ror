require 'rails_helper'

describe "articles", type: :feature do

  feature "view" do
    scenario "can view all articles by ordered published date in descending order" 
    scenario "can view an individual article" 
    scenario "cannot view an article that does not exist" 
    scenario "redirects me to view all articles and sends a warning notice when trying to view an article that does not exist" 
  end

  feature "view by author" do
    scenario "can view all articles by an author ordered by published date in descending order" 
    scenario "cannot view an article published by an author that does not exist" 
    scenario "sends a warning notice when trying to view articles by an author that does not exist" 
    scenario "sends a warning notice if trying to view articles by a given author where no articles exist" 
  end

  feature "view by date published" do
    scenario "can view all articles by within a given published date ordered by published date in descending order" 
    scenario "sends a warning notice if trying to view articles within a given published date where no articles exist" 
  end
end