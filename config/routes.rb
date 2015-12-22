Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get :unlock, to: "application#unlock", as: :unlock if Rails.env.development?
  root 'my/movies#index'

  resources :movies,  only: :show

  namespace :my do
    resources :movies, only: :index do
      post 'checked'
      post 'wait'
      post 'hate'
      post 'watch'
    end
    resources :groups, only: :show, to: "movies#index", param: :group
    resources :filters, only: [:destroy, :create]
  end
end
