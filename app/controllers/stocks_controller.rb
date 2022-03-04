class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'shared/search_result' }
        end
      else
        flash[:alert] = 'Please enter a valid symbol to search.'
        render 'users/my_portfolio'
      end

    else
      flash[:alert] = 'Please enter a symbol to search.'
      render 'users/my_portfolio'
    end
  end
end
