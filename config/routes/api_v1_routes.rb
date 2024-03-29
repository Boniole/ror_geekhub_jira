module ApiV1Routes
  def self.extended(router)
    router.instance_exec do
      namespace :v1 do
        resources :users, except: %i[update destroy] do
          put :update, on: :collection
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
          resources :memberships, only: [] do
            collection do
              post :create
              delete :destroy
            end
          end
          resources :github_repositories do
            collection do
              post 'create'
              put 'update'
              delete 'delete'
            end
          end
          resources :github_branches, only: %i[index show create]
          resources :github_commits, only: %i[show]
          resources :github_pullrequests, only: %i[create]
        end

        resources :github_users, only: %i[show]

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
