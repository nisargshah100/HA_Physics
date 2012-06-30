Feynman::Application.routes.draw do
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       # :registrations => "registrations" }
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [:show]
  resources :events, :only => [:create, :index, :new]
  resources :user_details, :only => [:edit, :update]
  resources :authentications, :only => [:new]
  resources :deals, :only => [:index]

  resources :signups, :only => [:new, :create] do
    collection do
      get  :preferences
      post :save_preferences
      post :personal_details
      post :save_personal_details
    end
  end
  
  resources :messages, :only => [:index, :show]
    
  namespace :api do
    namespace :v1 do
      resources :authentications, :only => [:index]
      resources :messages, :only => [:index, :show, :create]
      resources :events, :only => [:index]
      resources :images, :only => [:create, :index]
      resources :deals, :only => [:index]
      match '/user_details/:token' => 'user_details#update', :as => 'user_details'
    end
  end

  match '/profile/:slug' => 'users#show', :as => 'profile'
  root to: 'pages#index'
end
