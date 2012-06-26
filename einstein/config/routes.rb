Einstein::Application.routes.draw do
  devise_for :users

  resource :dashboard do
    namespace :data do
      get 'velocity' => 'dashboards#velocity'
    end
  end

  root :to => 'home#index'
end
