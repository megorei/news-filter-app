require 'spec_helper'

describe TaggedFeed do
  it { should validate_presence_of(:feed_id) }
  it { should validate_presence_of(:tag_id) }
end
