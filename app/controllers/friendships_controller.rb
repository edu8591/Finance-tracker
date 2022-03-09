class FriendshipsController < ApplicationController

  def destroy
    @friendship = Friendship.find_by(user: current_user, friend: params[:id])
    @friendship.destroy
    flash[:notice] = "#{@friendship.friend.full_name} was successfully removed from your friends list."
    redirect_to my_friends_path
  end
end
