class PortfoliosController < ApplicationController
  before_action :set_section
  before_action :login_required,  only: [:new, :create, :edit, :update, :destroy]
  before_action :fetch_portfolio, only: [:edit, :update, :destroy]

  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    if @portfolio.save
      redirect_to portfolio_index_path
    else
      render :new
    end
  end

  def update
    if @portfolio.update_attributes(portfolio_params)
      redirect_to portfolio_index_path
    else
      render :edit
    end
  end

  def destroy
    @portfolio.destroy

    redirect_to portfolio_index_path
  end

  private

  def set_section
    @section = 'portfolio'
  end

  def fetch_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:title, :short_description, :url, :identifier, :active_site)
  end
end
