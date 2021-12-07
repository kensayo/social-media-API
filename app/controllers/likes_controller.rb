class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'You liked a post')
    else
      rredirect_back(fallback_location: root_path, notice: 'You cannot like this post')
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      redirect_back(fallback_location: root_path, notice: 'You disliked this post')
    else
      redirect_back(fallback_location: root_path, alert: 'You cannot dislike post that you did not like before.')
    end
  end
end
