class FriendshipController < ApplicationController
  def create
    @friendship = Friendship.new friend_id: params[:user_id], user_id: current_user.id
    p @friendship.save
    redirect_back(fallback_location: root_path, notice: 'Request Friend')
  end

  def index
    @request = current_user.friend_requests
  end

  def accept
    @accept = Friendship.where(user_id: params[:user_id]).where(friend_id: current_user.id)
    p @accept
    if @accept.update(status: 1)
      redirect_back(fallback_location: root_path, notice: 'Friend Added')
    else
      flash.now[:alert] = 'Error while sending message!'
      render root_path
    end
  end

  def reject
    @accept = Friendship.where(user_id: params[:user_id]).where(friend_id: current_user.id)
    p @accept
    if @accept.update(status: 0)
      redirect_back(fallback_location: root_path, notice: 'Friend Added')
    else
      flash.now[:alert] = 'Error while sending message!'
      render root_path
    end
  end
end
