Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users
      get '/my_profile', to: 'users#show_current_user'
      get '/auth/:provider/callback', to: 'sessions#omniauth'
      post '/login', to: 'authentication#login'
      post '/forget_password', to: 'passwords#forget_password'
      post '/reset_password', to: 'passwords#reset_password'
      post '/update_password', to: 'passwords#update_password'

      resources :projects do
        resources :desks, only: %i[index show create update destroy]
        resources :columns, only: %i[show update destroy]
        resources :tasks, only: %i[show update destroy]
        resources :documents, except: :update
        member do
          post 'add_member', to: 'projects#add_member'
          delete 'delete_member', to: 'projects#delete_member'
        end
      end

      resources :columns, only: :create

      resources :tasks do
        resources :documents, except: :update
      end

      resources :comments, only: %i[create update destroy] do
        resources :documents, except: :update
      end

      resources :github_users, only: %i[show]

      resources :github_repositories do
        collection do
          post 'create'
          put 'update'
          delete 'delete'
        end
      end
    end

    namespace :v2 do
      get '/about_user', to: 'users#about_current_user' # collection show
      resources :users do
        member do
          get :comments
        end
      end
      get '/auth/:provider/callback', to: 'sessions#omniauth'
      post '/login', to: 'authentication#login'
      # rename forget_password
      post '/forgot', to: 'passwords#forgot'
      # rename reset to reset_password
      post '/reset', to: 'passwords#reset'
      # rename reset_password to update_password
      post '/reset_password', to: 'passwords#reset_in_settings'
      resources :projects do
        resources :desks
        resources :documents, except: :update
        member do
          post 'add_member', to: 'projects#add_member'
          delete 'delete_member/:user_id', to: 'projects#delete_member'
        end
      end
      # delete it
      # resources :desks do
      #   member do
      #     get :columns
      #   end
      # end

      # need check it
      resources :desks
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

      # need check it the same(36-42)
      resources :columns do
        resources :tasks do
          member do
            get :comments
          end
        end
      end
      # delete resources :tasks
      resources :tasks
      resources :comments

      resources :github_users, only: %i[show]
      resources :github_repositories do
        # collection do 63-66
        post 'create', on: :collection
        # patch - put
        patch 'update', on: :collection
        delete 'delete', on: :collection
      end
    end
  end
end
