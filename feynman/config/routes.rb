Feynman::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [:show]
  resources :events, :only => [:create, :index, :new]
  resources :user_details, :only => [:edit, :update]
  resources :signups, :only => [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :events, :only => [:index]
      match '/user_details/:token' => 'user_details#update', :as => 'user_details'
    end
  end

  match '/profile/:display_name' => 'users#show', :as => 'profile'
  root to: 'pages#index'
end
