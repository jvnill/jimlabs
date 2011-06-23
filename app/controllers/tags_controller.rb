class TagsController < ApplicationController
  skip_before_filter :login_required
  def show
    @posts = Post.tagged_with params[:tag_name]
    @portfolios = Portfolio.tagged_with params[:tag_name]
  end
end
