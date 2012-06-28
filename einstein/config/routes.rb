Einstein::Application.routes.draw do
  devise_for :users

  resource :dashboard do
    get 'data/velocity' => 'dashboards#velocity'
    get 'data/districts' => 'dashboards#districts'
    get 'data/projected_revenue' => 'dashboards#projected_revenue'
  end

  root :to => 'home#index'
end
