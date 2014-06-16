Rails.application.routes.draw do
  root 'ember_app#index'

  namespace :v1, constraints: { format: :json } do
    resources :tags
    resources :feeds
    resources :articles
    resources :tagged_feeds
    resources :sessions, only: [:create]
    resources :favorite_articles
    match '*unmatched_route', to: 'api#routing_error', via: :all
  end

end
