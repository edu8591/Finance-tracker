class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker]) || Stock.new_lookup(params[:ticker])
    stock.save if stock.id.nil?
    if UserStock.find_by(user: current_user, stock: stock)
      flash[:alert] = "You are already tracking #{stock.name} stock."
    else
      @user_stock = UserStock.create(user: current_user, stock: stock)
      flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."
    end
    redirect_to my_portfolio_path
  end
end
