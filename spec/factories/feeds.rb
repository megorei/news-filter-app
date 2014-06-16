# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    sequence(:title)  { |n| "MyFeed-#{n}" }
    sequence(:url)    { |n| "FEEDURL-#{n}" }
  end
end
