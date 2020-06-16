require 'rails_helper'

RSpec.describe Post, type: :model do
  context "validates" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_length_of(:title).is_at_least(10)}
    it {is_expected.to validate_presence_of :description}
    it {is_expected.to validate_length_of(:description).is_at_least(10)}
    it {is_expected.to validate_presence_of :salary}
    it {is_expected.to validate_presence_of :address}
    it {is_expected.to validate_presence_of :target_type}
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many(:skills).dependent(:destroy)}
    it {is_expected.to have_many :user_applies}
  end

  context "enums" do
    it {is_expected.to define_enum_for(:target_type).with_values([:freelance, :parttime, :fulltime])}
  end

  context "delegates" do
    it {is_expected.to delegate_method(:title).to(:category).with_prefix(true)}
  end

  context "accept_nested_attributes" do
    it {is_expected.to accept_nested_attributes_for(:skills).allow_destroy(true)}
  end
end
