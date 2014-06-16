# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite_article do
    user_id     { SecureRandom.uuid }
    article_id  { SecureRandom.uuid }
  end
end
