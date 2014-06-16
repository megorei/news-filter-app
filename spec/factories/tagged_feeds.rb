# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tagged_feed do
    feed_id { SecureRandom.uuid }
    tag_id  { SecureRandom.uuid }
  end
end
