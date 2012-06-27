Einstein::Application.routes.draw do
  devise_for :users

  resource :dashboard do
    get 'data/velocity' => 'dashboards#velocity'
    get 'data/districts' => 'dashboards#districts'
  end

  root :to => 'home#index'
end
