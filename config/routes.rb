Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/about_user', to: 'users#about_current_user'
      resources :users do
        member do
          get :comments
        end
      end
      post '/login', to: 'authentication#login'
      get '/auth/:provider/callback', to: 'sessions#omniauth'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      resources :projects do
        resources :documents, except: :update
        member do
          post 'add_member', to: 'projects#add_member'
          delete 'delete_member/:user_id', to: 'projects#delete_member'
        end
      end
      resources :desks do
        member do
          get :columns
        end
      end
      resources :columns
      resources :tasks do
        resources :documents, except: :update
        member do
          get :comments
        end
      end

      resources :comments do
        resources :documents, except: :update
      end
      resources :columns do
        resources :tasks do
          member do
            get :comments
          end
        end
      end
      resources :tasks
      resources :comments
      resources :documents

      resources :github_users, only: %i[show]
      resources :github_repositories do
        post 'create', on: :collection
        patch 'update', on: :collection
        delete 'delete', on: :collection
      end
    end
  end
end
