Rails.application.routes.draw do
  devise_for :users, controllers:{sessions: "users/sessions",
                                  registrations: "users/registrations",
                                  omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    resources :posts, only: :show
    resources :user_applies, only: %i(create destroy)
    resources :password_resets, except: %i(destroy show index)
    
    resources :users do
      member do
        get "/job_applieds", to: "job_applieds#index"
        resources :profiles, except: :index do
          patch "public", to: "status_profiles#update"
        end
      end
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
end
