module FindJob
  module V1
    class Users < Grape::API
      version "v1"
      format :json

      resources :users do
        desc "Create a user"
        params do
          requires :username, type: String, desc: "User name"
          requires :email, type: String, desc: "Email"
          requires :password, type: String, desc: "Password"
          requires :password_confirmation, type: String, desc: "Confirm passwrod" 
        end
        post "/sign_up" do
          u = User.new(
            username: params[:username],
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation] 
          )
          u.save
        end
      end
    end
  end
end
