# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    sequence(:title) { |n| "MyTag-#{n}" }
  end
end
