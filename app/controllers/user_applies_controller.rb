class UserAppliesController < ApplicationController
  before_action :logged_in_user, :load_post, only: %i(create destroy)   

  def create
    current_user.user_applies.create apply_params
    respond_to :js
  end

  def destroy
    return if current_user.user_applies.find_by(post_id: params[:id]).delete
    
    flash[:danger] = t "error.error"
    redirect_to "post/show"
    
    respond_to :js
  end

  private 

  def apply_params
    params.permit UserApply::USER_APPLY_PERMIT
  end

  def load_post
    @post = Post.find_by(id: params[:id] || params[:post_id])
  end
end
