Feynman::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [:show]
  resources :events, :only => [:create]

  namespace :api do
    namespace :v1 do
      resources :users, :only => [:index]
      resources :events, :only => [:create]
    end
  end

  match '/profile/:id' => 'users#show', :as => 'profile'
  root to: 'pages#index'
end
