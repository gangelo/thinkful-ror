# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    use_gravatar ""
    reference ""
  end
end
