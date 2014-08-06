class PortfoliosController < ApplicationController
  before_filter :set_section

  skip_before_filter :login_required, only: [:show, :index]

  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(params[:portfolio])

    if @portfolio.save
      redirect_to portfolio_index_path
    else
      render :new
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])

    if @portfolio.update_attributes(params[:portfolio])
      redirect_to portfolio_index_path
    else
      render :edit
    end
  end

  def destroy
    portfolio = Portfolio.find(params[:id])
    portfolio.destroy

    redirect_to portfolio_index_path
  end

  private

  def set_section
    @section = 'portfolio'
  end
end
