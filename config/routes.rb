Rails.application.routes.draw do
namespace :api do
  namespace :v1 do
      resources :tasks do 
        member do
          get :comments
        end
      end
    end
  end
end
