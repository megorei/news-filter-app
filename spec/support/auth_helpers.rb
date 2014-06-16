module AuthHelpers
  attr_accessor :current_user

  def auth_with(user)
    request.headers['X-API-TOKEN'] = "#{user.api_token}"
    self.current_user = user
  end

  def clear_token
    request.headers['X-API-TOKEN'] = nil
    self.current_user = nil
  end
end
