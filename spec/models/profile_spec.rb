require "rails_helper"

RSpec.describe Profile, type: :model do
  let!(:current_user) {FactoryBot.create :user}
  let!(:profile) {FactoryBot.create :profile, user_id: current_user.id}

  describe "Validation" do
    it {expect(profile).to be_valid}
  end
  
  describe "Associations" do
    it {expect(profile).to belong_to :user}
    it {expect(profile).to have_many(:profile_skills).dependent(:destroy)}
    it {expect(profile).to have_many(:experiences).dependent(:destroy)}
    it {expect(profile).to have_many(:qualifications).dependent(:destroy)}
  end

  describe "Enums" do
    it {expect(profile).to define_enum_for(:status).with_values([:private_cv, :public_cv])}
  end

  describe "Delegate" do
    it {is_expected.to delegate_method(:username).to(:user).with_prefix(true)}
  end

  describe "Nested attributes" do
    it {expect(profile).to accept_nested_attributes_for(:profile_skills).allow_destroy(true)}
    it {expect(profile).to accept_nested_attributes_for(:qualifications).allow_destroy(true)}
    it {expect(profile).to accept_nested_attributes_for(:experiences).allow_destroy(true)}
  end

  describe "#time" do
    it {expect(profile.time).to eq([I18n.l(profile.created_at), I18n.l(profile.updated_at)].join(" - "))}
  end
end
