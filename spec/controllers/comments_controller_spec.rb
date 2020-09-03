require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let!(:current_user){FactoryBot.create :user}
  let!(:category) {FactoryBot.create :category}
  let!(:company) {FactoryBot.create :company, user_id: current_user.id}
  let!(:post1){FactoryBot.create :post, user_id: current_user.id, category_id: category.id}
  let!(:comment) {FactoryBot.create :comment, user_id: current_user.id,commentable_id: post1.id, commentable_type: "Post"}

  describe "POST create" do
    context "when login " do
      let!(:comment_params){attributes_for(:comment, user_id: current_user.id, commentable_id: post1.id, commentable_type: "Post")}
      
      before do
        login current_user
        post :create, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id)
      end
      
      it "show status 200" do
        expect(response).to have_http_status(200)
      end

      it "create new comment" do
        expect{
          post :create, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id)
        }.to change(Comment, :count).by(1)
      end

      it "redirect to root_url when not found post" do
        post :create, xhr: true, params: {comment: comment_params}.merge(post_id: 10000)
        expect(response).to redirect_to root_url
      end
      
      it "show flash not found post" do
        post :create, xhr: true, params: {comment: comment_params}.merge(post_id: 10000)
        expect(flash[:danger]).to match(I18n.t("admin.post.not_found"))
      end
      
    end

    context "when not login" do
      let!(:comment_params){attributes_for(:comment, user_id: current_user.id, commentable_id: post1.id, commentable_type: "Post")}

      it "show status 401" do
        post :create, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET edit" do
    context "when login" do
      before{login current_user}

      let!(:comment_params){attributes_for(:comment, user_id: current_user.id, commentable_id: post1.id, commentable_type: "Post")}
      
      it "show status 200" do
        get :edit, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to have_http_status(200)
      end
      
      it "render template" do
        get :edit, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to render_template "comments/edit"
      end
    end
    
    context "when not login" do
      it "show status 401" do
        get :edit, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PATCH update" do
    context "when login" do
      before{login current_user}
      
      let!(:comment_params){attributes_for(:comment, user_id: current_user.id, commentable_id: post1.id, commentable_type: "Post")}

      it "show status 200" do
        put :update, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id, id: comment.id)
        expect(response).to have_http_status(200)
      end
      
      it "render template" do
        put :update, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id, id: comment.id)
        expect(response).to render_template "comments/create"
      end
      
    end
    
    context "when not login" do
      let!(:comment_params){attributes_for(:comment, user_id: current_user.id, commentable_id: post1.id, commentable_type: "Post")}

      it "show status 401" do
        put :update, xhr: true, params: {comment: comment_params}.merge(post_id: post1.id, id: comment.id)
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe "DELETE destroy" do
    context "when login" do
      before{login current_user}

      it "show status 200" do
        delete :destroy, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to have_http_status(200)
      end
      
      it "render template" do
        delete :destroy, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to render_template "comments/create"
      end
      
    end
    
    context "when not login" do
      it "show status 401" do
        delete :destroy, xhr: true, params: {post_id: post1.id, id: comment.id}
        expect(response).to have_http_status(401)
      end
    end
  end
end
