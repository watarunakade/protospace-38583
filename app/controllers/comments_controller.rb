class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    prototype = comment.prototype
      comments = prototype.comments
    if comment.save
      redirect_to prototype_path(comment.prototype_id)
    else  
      redirect_to prototype_path(comment.prototype_id)
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
