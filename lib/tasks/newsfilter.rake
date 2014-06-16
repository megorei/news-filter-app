namespace :newsfilter do
  namespace :rss_article do
    desc 'creates articles from rss feeds'
    task :create => :environment do
      Feed.all.each do |feed|
        RssArticleCreator.new(feed).create
      end
    end
  end
end