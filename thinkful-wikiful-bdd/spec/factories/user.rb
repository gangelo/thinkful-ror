
FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'GoodP@ssw0rd'
    password_confirmation 'GoodP@ssw0rd'
    user_name { Faker.bothify('??????????###') }

    factory :user_with_articles do
      after(:create) do |user, evaluator|
        user.articles << create_list(:article, rand(1..3), user: user)
      end
    end
  end
end