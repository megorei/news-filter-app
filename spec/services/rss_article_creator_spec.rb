require 'spec_helper'

describe RssArticleCreator do
  let(:feed) { create(:feed) }
  let!(:rss) { Feedjira::Feed.parse(File.open('spec/fixtures/rss.xml').read) }
  before { Feedjira::Feed.stub(:fetch_and_parse) { rss } }

  it 'fetches rss feed' do
    Feedjira::Feed.should_receive(:fetch_and_parse).once
    creator = RssArticleCreator.new(feed)
    creator.fetch
  end

  context 'fetch and create articles' do
    it 'creates new articles' do
      expect{
        creator = RssArticleCreator.new(feed).create
      }.to change(Article, :count)
    end

    it 'associates articles with feed' do
      creator = RssArticleCreator.new(feed).create
      feed.articles.size.should eq rss.entries.size
    end

    it 'should not reimport already imported articles' do
      creator = RssArticleCreator.new(feed).create
      feed.articles.size.should eq rss.entries.size
    end

  end

end

