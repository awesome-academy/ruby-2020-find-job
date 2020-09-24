Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
                     controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  
  mount API => "/"

  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: %i(omniauth_callbacks), 
                       controllers: {
                          sessions: "users/sessions",
                          registrations: "users/registrations"}

    root "static_pages#home"
    resources :user_applies, only: %i(create destroy)
    resources :password_resets, except: %i(destroy show index)
    resources :notifications, only: %i(index update)
    resources :searches, only: :index
  
    resources :users do
      member do
        get "/job_applieds", to: "job_applieds#index"
        resources :profiles, except: :index do
          patch "public", to: "status_profiles#update"
        end
      end
    end
  
    resources :posts, only: :show do
      resources :comments, except: %i(index show)
    end
  
    resources :comments, except: %i(index show) do
      resources :comments, except: %i(index show)
    end
  
    namespace :admin do 
      root to: "admins#index"

      resources :posts, except: %i(show)
      resources :users, only: %i(show)
      resources :profiles, only: %i(show)
      resources :user_applies, only: %i(index update destroy)
      resources :companies, only: %i(index edit update)
    end
  end
  mount ActionCable.server => '/cable'
end
