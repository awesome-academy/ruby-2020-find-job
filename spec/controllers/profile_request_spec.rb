require "rails_helper"

RSpec.describe ProfilesController, type: :controller do
  let!(:current_user) {FactoryBot.create :user}
  let!(:profile) {FactoryBot.create :profile, user_id: current_user.id}

  context "user login" do
    before {login current_user}
  
    describe "GET #new" do
      before{get :new, params: {id: current_user.id}}
      
      it "assigns a new Profile to @profile" do
        expect(assigns(:profile)).to be_a_new(Profile)
      end

      it "show new profile" do
        expect(response).to render_template :new
      end
    end

    describe "GET #show" do
      context "valid profile" do
        before {get :show, params: {id: current_user.id}}

        it "assigns a new Profile to @profile" do
          expect(assigns(:profile)).to eq(profile)
        end
    
        it "render show view" do
          expect(response).to render_template :show
        end
      end
      
      context "invalid profile" do
        it "not find profile & redirect to root url" do
          get :show, params: {id: "id_fail"}
          expect(response).to redirect_to root_url
        end
      end
    end

    describe "GET #edit" do
      before {get :edit, params: {id: profile.id}}

      it "find profile & render view edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        before {patch :update, params: {id: profile.id, profile: {title: "edit title"}}}
        
        it "show message sussess" do
          expect(flash[:success]).to match(I18n.t("notification.update_success"))
        end

        it "update success & redirect to user_path" do    
          expect(response).to redirect_to user_path
        end

        it "return profile" do
          expect(assigns :profile).to eq(profile)
        end
      end

      context "with invalid attributes" do
        it "redirect to user_path" do
          patch :update, params: {id: "id", profile: {title: "edit title"}}
          expect(response).to redirect_to root_path 
        end

        it "show message success" do
          patch :update, params: {id: profile.id, profile: {title: ""}}
          expect(flash.now[:danger]).to match(I18n.t("notification.update_fail"))        
        end
      end
    end
    
    describe "DELETE #destroy" do
      context "delete success" do
        describe "profile pending or unuse" do
          before {delete :destroy, params: {id: current_user.id, profile_id: profile.id}}
        
          it "show message success" do
            expect(flash[:success]).to match(I18n.t("notification.profile_delete"))
          end
        end
      end

      context "delete fail" do
        describe "profile approved" do
          let!(:category) {FactoryBot.create :category}
          let!(:post) {FactoryBot.create :post, user_id: current_user.id, category_id: category.id}
          let!(:user_apply) {FactoryBot.create :user_apply, user_id: current_user.id, post_id: post.id,             
                                                            profile_id: profile.id, status: "approved"}

          it "show message delete fail" do
            delete :destroy, params: {id: user_apply.profile_id}
            expect(flash[:danger]).to match(I18n.t("cv.cv_approved"))
          end
        end
      end
    end

    describe "POST #create" do
      context "with valid attribute" do
        before do
          post :create, params: {id: current_user.id, profile: FactoryBot.attributes_for(:profile, 
            user_id: current_user.id)}
        end

        it "save profile & show flash" do
          expect(flash[:success]).to match(I18n.t("notification.create_success"))  
        end

        it "create new profile" do
          expect{
            post :create, params: {id: current_user.id, profile: FactoryBot.attributes_for(:profile, 
              user_id: current_user.id)}
          }.to change(Profile, :count).by(1)  
        end

        it "redirec to root url" do
          expect(response).to redirect_to root_url 
        end
      end
      
      context "with invalid attribute" do
        before do
          post :create, params: {id: current_user.id, profile: {title: "title"}}
        end

        it "show message fail" do
          expect(flash[:danger]).to match(I18n.t("notification.create_fail"))  
        end
        
        it "render view" do
          expect(response).to render_template :new
        end 
      end
    end
  end

  context "not login" do
    describe "GET #new" do
      before {get :new, params: {id: current_user.id, locale: "vi"}}
      
      it {expect(response).to redirect_to new_user_session_url}
    end

    describe "GET #edit" do
      before {get :edit, params: {id: current_user.id, locale: "vi"}}
      
      it {expect(response).to redirect_to new_user_session_url}
    end

    describe "GET #show" do
      before {get :show, params: {id: current_user.id, locale: "vi"}}
      
      it {expect(response).to redirect_to root_url}
    end

    describe "PATCH #update" do
      before {patch :update, params: {id: current_user.id, locale: "vi", profile: {title: "edit title"}}}
      
      it {expect(response).to redirect_to new_user_session_url}
    end

    describe "DELETE #destroy" do
      before {delete :destroy, params: {id: profile.id, locale: "vi"}}

      it {expect(response).to redirect_to user_session_path}
    end
    describe "POST #create" do
      before {post :create, params: {id: current_user.id,locale: "vi", 
              profile: FactoryBot.attributes_for(:profile, user_id: current_user.id)}}
      it {expect(response).to redirect_to user_session_path}
    end  
  end
end
