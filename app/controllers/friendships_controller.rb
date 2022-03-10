class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend])
    if @friendship.save
      flash[:notice] = "#{@friendship.friend.full_name} successfully added to friends."
    else
      flash[:alert] = 'Something went wrong with the request.'
    end
    redirect_to my_friends_path
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend: params[:id])
    @friendship.destroy
    flash[:notice] = "#{@friendship.friend.full_name} was successfully removed from your friends list."
    redirect_to my_friends_path
  end
end
