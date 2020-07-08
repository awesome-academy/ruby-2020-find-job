require "rails_helper"

RSpec.describe Qualification, type: :model do
  let!(:current_user) {FactoryBot.create :user}
  let!(:profile) {FactoryBot.create :profile, user_id: current_user.id}
  let!(:qualification) {FactoryBot.build :qualification, profile_id: profile.id}

  describe "#qualification_start_time_invalid" do
    subject do
      qualification.valid?
      qualification.errors.messages[:start_time].present?
    end

    context "when start time is invalid" do
      it do 
        is_expected.to eq(true)
      end
    end

    context "when start time is valid" do
      before do
        qualification.start_time = "2020/06/20"
      end
      it do 
        is_expected.to eq(false)
      end
    end
  end
end
