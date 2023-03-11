Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'authentication#login'
      resources :projects
      resources :desks
      resources :tasks do
        member do
          get :comments
        end
      end
    end
  end
end
