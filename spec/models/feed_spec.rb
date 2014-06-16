require 'spec_helper'

describe Feed do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }

  it { should validate_uniqueness_of(:title) }
  it { should validate_uniqueness_of(:url) }

  it { should have_many(:articles) }
end
