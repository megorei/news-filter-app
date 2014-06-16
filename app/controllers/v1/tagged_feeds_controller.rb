class V1::TaggedFeedsController < V1::ApiController
  before_action :init_tagged_feed, only: [:show, :update, :destroy]

  def index
    render json: TaggedFeed.includes(:tag, :feed)
  end

  def show
    render json: @feed
  end

  def create
    @feed = TaggedFeed.create!(tagged_feed_params)
    render json: @feed
  end

  def update
    @feed.update_attributes!(tagged_feed_params)
    render json: @feed
  end

  def destroy
    @feed.destroy!
    render text: :nothing, status: :no_content
  end

  private

  def init_tagged_feed
    @feed = TaggedFeed.find params[:id]
  end

  def tagged_feed_params
    params[:tagged_feed].permit(:feed_id, :tag_id)
  end
end
