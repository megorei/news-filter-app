class V1::FavoriteArticlesController < V1::ApiController
  before_action :init_favorite_article, only: [:show, :update, :destroy]

  def index
    render json: FavoriteArticle.includes(:user, :article)
  end

  def show
    render json: @favorite_article
  end

  def create
    @favorite_article = FavoriteArticle.create!(favorite_article_params)
    render json: @favorite_article
  end

  def update
    @favorite_article.update_attributes!(favorite_article_params)
    render json: @favorite_article
  end

  def destroy
    @favorite_article.destroy!
    render text: :nothing, status: :no_content
  end

  private

  def init_favorite_article
    @favorite_article = FavoriteArticle.find params[:id]
  end

  def favorite_article_params
    params[:favorite_article].permit(:article_id).merge(user_id: current_user.id)
  end
end
