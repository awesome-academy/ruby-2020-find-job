class CommentsController < ActionController::Base
  before_action :authenticate_user!
  before_action :load_post, only: %i(create edit update destroy)
  before_action :load_comment, only: %i(edit update destroy)
  before_action :load_comments,only: %i(create update destroy)

  def create
    @comment = @post.comments.build comment_params
    @msg = t "comment.create" if @comment.save

    respond_to :js
  end

  def edit; end

  def update
    @msg = t "comment.update" if @comment.update comment_params
    
    respond_to do |format|
      format.js{
        render template: "comments/create", layout: false
      }
    end
  end
  
  def destroy
    @msg = t "comment.destroy" if @comment.destroy
   
    respond_to do |format| 
    format.js{
      render template: "comments/create", layout: false     
    }
    end
  end

  private 
  
  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment

    flash[:danger] = t "comment.comment_exist"
    redirect_to root_url
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
    return if @post

    flash[:danger] = t "admin.post.not_found"
    redirect_to root_url
  end

  def load_comments
    @comments = Post.find_by(id: params[:post_id]).comments.by_created_at
  end
  
  def comment_params 
    params.require(:comment).permit(Comment::COMMENT_PARAMS).merge user_id: current_user.id
  end
end
