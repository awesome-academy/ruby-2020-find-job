class UsersController < ApplicationController
  def show
    @profile = current_user.profiles.by_created_at.page(params[:page]).per Settings.profile_per_page
  end
end
