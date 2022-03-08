class UserStocksController < ApplicationController
  before_action :set_user_stock, only: :destroy

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

  def destroy
    @user_stock.destroy
    flash[:notice] = "#{@user_stock.stock.ticker} was successfully removed from your portfolio."
    redirect_to my_portfolio_path
  end

  private
  def set_user_stock
    @user_stock = UserStock.find_by(user: current_user, stock: params[:id])
  end
end
