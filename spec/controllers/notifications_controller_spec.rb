require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  let!(:sender_user) {FactoryBot.create :user}
  let!(:category) {FactoryBot.create :category}
  let!(:company) {FactoryBot.create :company, user_id: sender_user.id}
  let!(:post){FactoryBot.create :post, user_id: sender_user.id, category_id: category.id}
  let!(:receiver_user) {FactoryBot.create :user}
  let!(:notification) {FactoryBot.create :notification, creator_id: sender_user.id, receiver_id: receiver_user.id, data: "notification_success", post_id: post.id}

  describe "GET #index" do
    context "when not login" do
      before {get :index, params: {locale: "vi"}}

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "when login" do
      before {login receiver_user}
      
      it "return list notification" do
        get :index, params: {locale: "vi"}
        expect(assigns(:notifications)).to eq receiver_user.notifications
      end
    end
  end

  describe "PUT #update" do
    context "when not login" do
      before {put :update, params: {locale: "vi", id: notification.id}}

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_url
      end
    end
    
    context "when login" do
      before do 
        login receiver_user 
        put :update, params: {locale: "vi", id: notification.id}
      end

      it "update notification" do
        notification.reload
        expect(notification.viewed).to eq true
      end
      
      it "redirect to post" do
        expect(response).to redirect_to post_url
      end
    end
  end
end
