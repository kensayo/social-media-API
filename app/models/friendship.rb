class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.requested?(request_id, my_friend)
    return true if Friendship.where(user_id: request_id).where(friend_id: my_friend).exists?

    return true if Friendship.where(user_id: my_friend).where(friend_id: request_id).exists?

    false
  end

  def self.friends(request_id)
    my_friends = []
    friends = Friendship.where(user_id: request_id).or(Friendship.where(friend_id: request_id)).where(status: 1)
    friends.each do |users|
      if users.user_id == request_id
        my_friends.push(users.friend_id)
      else
        my_friends.push(users.user_id)
      end
    end
    my_friends
  end
end
