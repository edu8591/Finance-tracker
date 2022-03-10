class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:query].present?
      @friends = User.search(params[:query])
      if @friends
        respond_to do |format|
          format.js { render partial: 'shared/friend_search_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'We coudnt find any user with that name or email.`'
          format.js { render partial: 'shared/friend_search_result' }
        end
        # render 'users/my_portfolio'
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a name or email to search.'
        format.js { render partial: 'shared/friend_search_result' }
      end
      # render 'users/my_portfolio'
    end
  end
end
