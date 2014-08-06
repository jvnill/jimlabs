class PostsController < ApplicationController
  before_filter :set_section

  skip_before_filter :login_required, only: [:show, :index]

  def index
    @posts = Post.published.paginate(page: params[:page], per_page: 5)
    @meta  = { keywords: Post.meta_tags, description: Post.meta_desc }
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to post_path(@post)
    else
      render :action => :new
    end
  end

  def show
    @post       = Post.where(:path => params[:id]).first
    @page_title = @post.title
    @meta       = { keywords: @post.tag_list, description: Array(@post.meta) }
    @comment    = Comment.new :commentable_id => @post.id, :commentable_type => 'Post'
    @comments   = @post.comments.approved
  end

  def edit
    @post = Post.where(:path => params[:id]).first
  end

  def update
    @post = Post.where(:path => params[:id]).first

    if @post.update_attributes(params[:post])
      redirect_to post_path(@post)
    else
      render :action => :edit
    end
  end

  def destroy
  end

  def set_section
    @section = 'blog'
  end
end
