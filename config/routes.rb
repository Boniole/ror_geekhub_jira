Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'authentication#login'
      resources :tasks do
        member do
          get :comments
        end
      end
    end
  end
end
