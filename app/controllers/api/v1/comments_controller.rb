class Api::V1::CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment.post_id = params[:post_id]
    @comment.user = current_user
    comment = post.comments.build(user_id: current_user.id, content: params[:content])
    if comment.save
      render json: comment
    else
      render plain: 'comment not created', status: :bad_request, message: 'comment not created'
    end
  end
end