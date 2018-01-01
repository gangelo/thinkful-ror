FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.paragraph[0..(rand(11..63))] }
    content { Faker::Lorem.paragraph[0..(rand(150..500))] }
    categories { create_list(:category, rand(1..3)) }
  end
end
