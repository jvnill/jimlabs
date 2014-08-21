class TagsController < ApplicationController
  skip_before_action :login_required

  def show
    @posts = Post.tagged_with(params[:tag_name])
  end
end
