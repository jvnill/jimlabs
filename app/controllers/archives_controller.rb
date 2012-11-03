class ArchivesController < ApplicationController
  skip_before_filter :login_required

  def show
    @posts = Post

    if params[:date]
      month, year = params[:date].split(' ')
      start_date  = Date.new(year.to_i, Date::MONTHNAMES.rindex(month), 1) rescue nil

      @posts = Post.where(created_at: start_date..start_date.end_of_month) if start_date
    end

    @posts = @posts.page(params[:page]).per_page(5)
    render template: '/posts/index'
  end
end
