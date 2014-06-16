class V1::FeedsController < V1::ApiController
  before_action :init_feed, only: [:update, :destroy]

  def index
    render json: Feed.includes(:tagged_feeds)
  end

  def show
    @feed = Feed.find params[:id]
    render json: @feed
  end

  def create
    @feed = current_user.feeds.create!(feed_params)
    render json: @feed, status: :created
  end

  def update
    @feed.update_attributes!(feed_params)
    render json: @feed
  end

  def destroy
    @feed.destroy!
    render text: :nothing, status: :no_content
  end

  private

  def init_feed
    @feed = Feed.find params[:id]
  end

  def feed_params
    params[:feed].permit(:title, :url)
  end
end
