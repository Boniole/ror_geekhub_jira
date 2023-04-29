module ApiV1Routes
  def self.extended(router)
    router.instance_exec do
      namespace :v1 do
        resources :users, except: %i[update destroy] do
          patch :update, on: :collection
          delete :destroy, on: :collection
        end
        get '/my_profile', to: 'users#show_current_user'
        get '/auth/:provider/callback', to: 'sessions#omniauth'
        post '/login', to: 'authentication#login'
        post '/forget_password', to: 'passwords#forget_password'
        post '/reset_password', to: 'passwords#reset_password'
        patch '/update_password', to: 'passwords#update_password'

        resources :projects do
          resources :desks, only: %i[index show create update destroy]
          resources :columns, only: %i[create show update destroy]
          resources :tasks, only: %i[create show update destroy]
          resources :comments, only: %i[create update destroy]
          member do
            post 'add_member', to: 'projects#add_member'
            delete 'delete_member', to: 'projects#delete_member'
          end
        end

        resources :github_users, only: %i[show]
        resources :github_repositories do
          collection do
            post 'create'
            put 'update'
            delete 'delete'
          end
        end
        resources :github_branches do
          collection do
            get 'index'
            post 'create'
          end
        end

        concern :documentable do
          resources :documents, except: :update
        end

        resources :projects, concerns: :documentable
        resources :tasks, concerns: :documentable
        resources :comments, concerns: :documentable
      end
    end
  end
end
