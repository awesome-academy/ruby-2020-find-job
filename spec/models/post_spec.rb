require "rails_helper"

RSpec.describe Post, type: :model do
  let!(:current_user) {FactoryBot.create :user}
  let!(:category) {FactoryBot.create :category}
  let!(:post) {FactoryBot.create :post, user_id: current_user.id, category_id: category.id}

  subject {FactoryBot.build :post, user_id: current_user.id, category_id: category.id}

  describe "Validation" do
    it {is_expected.to be_valid}
  end

  describe "Associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many(:skills).dependent(:destroy)}
    it {is_expected.to have_many :user_applies}
  end

  describe "Enums" do
    it {is_expected.to define_enum_for(:target_type).with_values([:freelance, :parttime, :fulltime])}
  end

  describe "Delegate" do
    it {is_expected.to delegate_method(:title).to(:category).with_prefix(true)}
  end

  describe "Nested attributes" do
    it {is_expected.to accept_nested_attributes_for(:skills).allow_destroy(true)}
  end

  describe "#apply_time" do
    it {expect(subject.apply_time).to eq([subject.start_date, subject.end_date].join(" - "))}
  end

  describe ".post_listed" do
    it {expect(Post.post_listed([1,2,3])).to eq(Post.where(id: [1,2,3])) }
  end
end
