Einstein::Application.routes.draw do
  devise_for :users

  resources :categories
  resources :divisions
  
  resource :dashboard do
    get 'data/velocity' => 'dashboards#velocity'
    get 'data/districts' => 'dashboards#districts'
    get 'data/projected_revenue' => 'dashboards#projected_revenue'
    get 'data/deal_probability' => 'dashboards#deal_probability'
  end

  root :to => 'home#index'
end
