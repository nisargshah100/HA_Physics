Einstein::Application.routes.draw do
  devise_for :users

  resource :dashboard do
    get 'data/velocity' => 'dashboards#velocity'
  end

  root :to => 'home#index'
end
