class PortfoliosController < ApplicationController
  before_filter :set_section
  skip_before_filter :login_required, :only => [:show, :index]

  def index
    @portfolios = Portfolio.published
  end

  def new
    @portfolio = Portfolio.new
  end
  
  def create
    @portfolio = Portfolio.new(params[:portfolio])

    if @portfolio.save
      redirect_to portfolios_path
    else
      render :action => :new
    end
  end

  def show
    @portfolio = Portfolio.find_by_path(params[:id])
    @page_title = @portfolio.title
    @meta = {:keywords => @portfolio.tag_list.join(', '), :description => @portfolio.meta}
    @comment = Comment.new :commentable_id => @portfolio.id, :commentable_type => 'Portfolio'
  end

  def edit
    @portfolio = Portfolio.find_by_path(params[:id])
  end

  def update
    @portfolio = Portfolio.find_by_path(params[:id])

    if @portfolio.update_attributes(params[:portfolio])
      redirect_to portfolio_path(@portfolio)
    else
      render :action => :edt
    end
  end

  def destroy
    @portfolio = Portfolio.find_by_path(params[:id])
  end

  private
  def set_section
    @section = 'portfolio'
  end
end
