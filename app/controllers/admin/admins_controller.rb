class Admin::AdminsController < ApplicationController
  layout "layouts/admin"

  before_action :authenticate_user!
  authorize_resource
  
  def index
    @posts = current_user.posts
    @profile_applies = UserApply.post_applies @posts.ids
  end
end
