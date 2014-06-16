require 'spec_helper'

describe FavoriteArticle do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:article_id) }
end
