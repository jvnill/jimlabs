class ArchivesController < ApplicationController
  skip_before_filter :login_required

  def show
    if params[:date]
      month, year = params[:date].split(' ')
      start_date  = Date.new(year.to_i, Date::MONTHNAMES.rindex(month), 1)
      end_date    = start_date.end_of_month
      @posts = Post.all(:conditions => {:created_at => start_date..end_date}).paginate(:page => params[:page], :per_page => 5)
      render :template => '/posts/index'
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
