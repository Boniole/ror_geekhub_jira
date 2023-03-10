Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'users#login'
      resources :tasks do 
        member do
          get :comments
        end
      end
    end
  end
end
