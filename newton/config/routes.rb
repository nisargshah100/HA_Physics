Newton::Application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :deals do
        collection do
          get 'fetch' => 'deals#fetch'
        end
      end

      resources :categories, :only => [:index]
      resources :events, :only => [:index]
    end
  end
end
