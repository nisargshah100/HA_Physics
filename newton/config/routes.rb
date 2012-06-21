Newton::Application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :deals, :only => [:show, :index]
      resources :categories, :only => [:index]
    end
  end
end
