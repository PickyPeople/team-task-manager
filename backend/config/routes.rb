Rails.application.routes.draw do
  devise_for :users
  # 기존 헬스체크
  get "up" => "rails/health#show", as: :rails_health_check

  # 사용자 인증 관련 API 라우트
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'
  get '/me', to: 'users#me'
  post "/logout", to: "users#logout"
  post '/workspaces/:id/join', to: 'workspaces#join'
  get  '/workspaces/:id/participants', to: 'workspaces#participants'
  delete '/workspaces/:id/leave', to: 'workspaces#leave'
 
  resources :workspaces, only: [:create, :index, :show, :update, :destroy] do
    resources :tasks, only: [:index, :create, :update, :destroy, :show]
  end  
end
