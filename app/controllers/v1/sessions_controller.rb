class V1::SessionsController < V1::ApiController
  skip_before_action :restrict_access

  def create
    @user = User.authenticate(session_params[:email], session_params[:password])
    if @user
      render json: {session: {api_token: @user.api_token, user_id: @user.id}}, status: :created
    else
      render json: {error: "Authentication failed"}, status: :unprocessable_entity
    end
  end

  private
  def session_params
    params[:session].permit(:email, :password)
  end
end
