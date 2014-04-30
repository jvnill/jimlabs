class ArchivesController < ApplicationController
  skip_before_filter :login_required

  def show
    date = Date.parse(params[:date]) rescue nil

    @posts = Post.for_date(date).page(params[:page]).per_page(5)

    render template: '/posts/index'
  end
end
