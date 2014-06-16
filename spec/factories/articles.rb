# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyText"
    sequence(:url) { |n| "ARTICLEURL-#{n}" }
    description "MyText"
    entry_id { SecureRandom.uuid }
  end
end
