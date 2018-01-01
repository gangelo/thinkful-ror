require 'ffaker'

namespace :seed do
  desc "Create 10 users with articles"
  task users: :environment do
    FactoryGirl.create_list(:user_with_articles, 10)
  end

  desc "Create an account for me"
  task me: :environment do
    user = User.create!(name: 'Gene M. Angelo, Jr.', email: 'web.gma@gmail.com', user_name: 'gangelo', password: 'I8All3Zots#04')
    10.times { FactoryGirl.create(:article, user: user) }
  end
end