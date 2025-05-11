Rails.application.routes.draw do
  devise_for :users
  # 기존 헬스체크
  get "up" => "rails/health#show", as: :rails_health_check

  # 사용자 인증 관련 API 라우트
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'
  get '/me', to: 'users#me'
  post "/logout", to: "users#logout"
 resources :workspaces, only: [:create, :index, :show, :destroy]
end
