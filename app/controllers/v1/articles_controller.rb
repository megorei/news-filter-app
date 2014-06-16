class V1::ArticlesController < V1::ApiController
  before_action :init_article, only: :show

  def index
    render json: Article.includes(:feed, :users)
  end

  def show
    render json: @article
  end

  private

  def init_article
    @article = Article.find params[:id]
  end

end