Einstein::Application.routes.draw do
  devise_for :users

  resource :dashboard do
    scope :data do
      get 'velocity' => 'dashboards#velocity'
    end
  end

  root :to => 'home#index'
end
