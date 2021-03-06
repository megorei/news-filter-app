require 'spec_helper'

describe Tag do
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
end
