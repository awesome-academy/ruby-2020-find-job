require "rails_helper"

RSpec.describe Admin::PostsController, type: :controller do
  context "Not login" do
    let!(:current_user) {FactoryBot.create :user}
    let!(:category) {FactoryBot.create :category}

    describe "GET #index" do
      before {get :index}

      include_examples "login page"
    end

    describe "GET #new" do
      before {get :new}

      include_examples "login page"
    end

    describe "POST #create" do
      before do
        post :create, params: {post: FactoryBot.attributes_for(:post, user_id: current_user.id,
                                                               category_id: category.id)}
      end

      include_examples "login page"
    end

    describe "GET #edit" do
      let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

      before {get :edit, params: {id: post.id}}

      include_examples "login page"
    end

    describe "PATCH #update" do
      let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

      before {patch :update, params: {id: post.id, post: {title: "edit title"}}}

      include_examples "login page"
    end

    describe "DELETE #destroy" do
      let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

      before {delete :destroy, params: {id: post.id}}

      include_examples "login page"
    end
  end

  context "Logged in" do
    let!(:current_user) {FactoryBot.create :user}
    let!(:other_user) {FactoryBot.create :user}
    let!(:category) {FactoryBot.create :category}

    before {login current_user}

    describe "GET #index" do
      before {get :index}

      it "show all post by current_user" do
        expect(assigns :posts).to eq current_user.posts
      end
    end

    describe "GET #new" do
      before {get :new}

      it "render template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "create post success" do
        before do
          post :create, params: {post: FactoryBot.attributes_for(:post, user_id: current_user.id,
                                                                 category_id: category.id)}
        end

        it "show status" do
          expect(response).to have_http_status(302)
        end

        it "show messages success" do
          expect(flash[:success]).to match(I18n.t("notification.post_success"))
        end

        it "creates a new post" do
          expect{
            post :create, params: {post: FactoryBot.attributes_for(:post, user_id: current_user.id,
                                                                   category_id: category.id)}
          }.to change(Post, :count).by(1)
        end
      end

      context "create post fail" do
        before do
          post :create, params: {post: {title: "test title"}}
        end

        it "show messages fail" do
          expect(flash[:danger]).to match(I18n.t("notification.post_fail"))
        end
      end
    end

    describe "GET #edit" do
      context "find post" do
        let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

        before {get :edit, params: {id: post.id}}

        it "should found" do
          expect(response).to have_http_status(:ok)
        end

        it "render template" do
          expect(response).to render_template :edit
        end
      end

      context "post not found" do
        before {get :edit, params: {id: "id_fail"}}

        it "load post fail" do
          expect(flash[:danger]).to match(I18n.t("admin.post.not_found"))
        end
      end
    end

    describe "PATCH #update" do
      context "update post success" do
        let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

        before {patch :update, params: {id: post.id, post: {title: "edit title"}}}

        it "show message success" do
          expect(response).to have_http_status(302)
          expect(flash[:success]).to match(I18n.t("admin.post.update_success"))
        end

        it "return post" do
          expect(assigns :post).to eq post
        end
      end

      context "update post fail" do
        before {patch :update, params: {id: "id_fail", post: {title: "edit title"}}}

        it "show messages fail" do
          expect(flash[:danger]).to match(I18n.t("admin.post.not_found"))
        end
      end
    end

    describe "DELETE #destroy" do
      context "detele success" do
        let!(:post){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

        before {delete :destroy, params: {id: post.id}}

        it "show messages success" do
          expect(response).to have_http_status(302)
          expect(flash[:success]).to match(I18n.t("admin.post.delete_success"))
        end
      end

      context "detele fail" do
        before {delete :destroy, params: {id: "id_fail"}}

        it "show messages fail" do
          expect(flash[:danger]).to match(I18n.t("admin.post.not_found"))
        end
      end
    end
  end
end
