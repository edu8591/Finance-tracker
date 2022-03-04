class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      flash[:alert] = 'Please enter a valid symbol to search.' unless @stock
    else
      flash[:alert] = 'Please enter a symbol to search.'
    end
    render 'users/my_portfolio'
  end
end
