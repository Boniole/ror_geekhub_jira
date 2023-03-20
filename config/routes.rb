Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          get :comments
        end
      end
      post '/login', to: 'authentication#login'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      resources :projects
      resources :desks do
        member do
          get :columns
        end
      end
      resources :columns
      resources :tasks do
        member do
          get :comments
        end
      end
      resources :comments
    end
  end
end
