module ApiV2Routes
  def self.extended(router)
    router.instance_exec do
      namespace :v2 do
        get '/about_user', to: 'users#about_current_user'
        resources :users do
          member do
            get :comments
          end
        end
        get '/auth/:provider/callback', to: 'sessions#omniauth'
        post '/login', to: 'authentication#login'
        post '/forget_password', to: 'passwords#forgot'
        post '/reset_password', to: 'passwords#reset'
        patch '/update_password', to: 'passwords#reset_in_settings'
        resources :projects do
          resources :desks
          resources :documents, except: :update
          member do
            post 'add_member', to: 'projects#add_member'
            delete 'delete_member', to: 'projects#delete_member'
          end
        end

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

        resources :columns do
          resources :tasks do
            member do
              get :comments
            end
          end
        end
        resources :tasks
        resources :comments

        resources :github_users, only: %i[show]
        resources :github_repositories do
          post 'create', on: :collection
          patch 'update', on: :collection
          delete 'delete', on: :collection
        end
      end
    end
  end
end
