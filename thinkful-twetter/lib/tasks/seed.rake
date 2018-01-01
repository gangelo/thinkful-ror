require 'digest/md5'
require 'ffaker'

namespace :seed do
  desc "Create 5 twets for each user"
  task :twets => :environment do
    User.find_each do |user|
      5.times do
        Twet.create(:user => user, :content => Faker::Lorem.sentence(3))
      end
    end
  end

  desc "Create 20 users"
  task :users => :environment do
    20.times do
      user = User.create!(:email => Faker::Internet.email, :name => Faker::Name.name, :password => Faker.bothify("####????##??"), :username => Faker::Name.first_name)
      UserProfile.create!(user_id: user.id)
    end
  end

  desc "Create an account for me"
  task :me => :environment do
    # Add me.
    user = User.create!(email: 'web.gma@gmail.com', name: 'Gene M. Angelo, Jr.',
      password: 'password', username: 'gangelo')
    UserProfile.create!(user_id: user.id, gravatar_hash: Digest::MD5.hexdigest(user.email.downcase))
  end
end
