require "rails_helper"

RSpec.describe UserApply, type: :model do
  let!(:current_user) {FactoryBot.create :user}
  let!(:profile) {FactoryBot.create :profile, user_id: current_user.id}
  let!(:category) {FactoryBot.create :category}
  let!(:post) {FactoryBot.create :post, user_id: current_user.id, category_id: category.id}
  let!(:user_apply) {FactoryBot.create :user_apply, user_id: current_user.id, post_id: post.id, profile_id: profile.id}

  describe "#status_i18n" do
    it {expect(user_apply.status_i18n).to eq(I18n.t("enums.userapply.status.#{user_apply.status}"))}
  end

  describe ".post_applies" do
    it {expect(current_user.user_applies.post_applies(1).present?).to eq(false)}
  end
end
