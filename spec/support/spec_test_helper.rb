module SpecTestHelper
  def login user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryBot.create(:user)
    user.confirm
    sign_in user
  end
end
