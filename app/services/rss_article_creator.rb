class RssArticleCreator
  attr_accessor :feed, :articles

  def initialize(feed)
    self.feed = feed
  end

  def truncate(string, length)
    truncated = string.gsub(/\s+/, ' ')[0...length]
    truncated.length < string.length ? truncated + '...' : truncated
  end

  def create
    fetch
    create_articles
  end

  def fetch
    f = Feedjira::Feed.fetch_and_parse feed.url
    self.articles = f.entries.map do |entry|
      sanitize convert_keys Hash[entry.to_a]
    end
  end

  def create_articles
    articles.each do |article|
      feed.articles.create(article)
    end
  end

  protected

  def sanitize(hash)
    hash['description'] = truncate(Sanitize.clean(hash['description'].to_s, remove_contents: %w[style script object embed head]), 500)
    hash
  end

  def convert_keys(hash)
    hash['summary'] ||= hash['content']
    hash['url']     ||= hash['links'].try(:first)
    Hash[hash.map{|k,v| [mapping[k], v]}].reject{|k, v| k == nil}
  end

  def mapping
    {   'title'     => 'title',
        'url'       => 'url',
        'image'     => 'image_url',
        'published' => 'published_at',
        'summary'   => 'description',
        'entry_id'  => 'entry_id'
    }
  end

end