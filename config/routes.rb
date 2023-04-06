Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/about_user', to: 'users#about_current_user'
      resources :users do
        resources :documents
        member do
          get :comments
        end
      end
      post '/login', to: 'authentication#login'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      resources :projects do
        member do
          post 'add_member', to: 'projects#add_member'
          delete 'delete_member/:user_id', to: 'projects#delete_member'
        end
        resources :documents
      end
      resources :desks do
        member do
          get :columns
        end
      end
      resources :columns do
        resources :tasks do
          resources :documents
          member do
            get :comments
          end
        end
      end
      resources :tasks
      resources :comments
      resources :documents
      # get '/github/show', to: 'github#show'
      resources :githubs do
        post 'show', on: :collection
        post 'create', on: :collection
      end
    end
  end
end
