class V1::TagsController < V1::ApiController
  before_action :init_tag, only: [:show, :update, :destroy]

  def index
    render json: Tag.includes(:tagged_feeds)
  end

  def show
    render json: @tag
  end

  def create
    @tag = Tag.create!(tag_params)
    render json: @tag, status: :created
  end

  def update
    @tag.update_attributes!(tag_params)
    render json: @tag
  end

  def destroy
    @tag.destroy!
    render text: :nothing, status: :no_content
  end

  private

  def init_tag
    @tag = Tag.find params[:id]
  end

  def tag_params
    params[:tag].permit(:title)
  end
end
