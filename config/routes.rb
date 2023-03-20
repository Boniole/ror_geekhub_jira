Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'authentication#login'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      resources :projects
      resources :desks
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
