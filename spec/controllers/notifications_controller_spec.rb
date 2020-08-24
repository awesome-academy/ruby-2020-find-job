require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  let!(:sender_user) {FactoryBot.create :user}
  let!(:company) {FactoryBot.create :company, user_id: sender_user.id}
  let!(:receiver_user) {FactoryBot.create :user}
  let!(:notifications) {FactoryBot.create :notification, creator_id: sender_user.id, receiver_id: receiver_user.id, data: "notification_success"}

  describe "GET #index" do
    context "when not login" do
      before {get :index, params: {locale: "vi"}}

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "when login" do
      before {login receiver_user}
      
      it "return list notifications" do
        get :index, params: {locale: "vi"}
        expect(assigns(:notifications)).to eq receiver_user.notifications
      end
    end
  end
end
