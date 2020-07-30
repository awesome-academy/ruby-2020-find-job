require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  
  describe "GET #index" do
    let(:sender_user) {FactoryBot.create :user}
    let(:receiver_user) {FactoryBot.create :user}
    let!(:notifications) {FactoryBot.create :notification, creator_id: sender_user.id, receiver_id: receiver_user.id, data: "notification_success"}

    context "when not login" do
      before {get :index, params: {locale: "vi"}}

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "when login" do
  
      it "return list notifications" do
        login receiver_user
        get :index, params: {locale: "vi"}
        expect(assigns(:notifications)).to eq receiver_user.notifications
      end
    end
  end
end
