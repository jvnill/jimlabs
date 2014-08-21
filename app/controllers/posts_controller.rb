class PostsController < ApplicationController
  skip_before_action :login_required, only: [:show, :index]

  before_action :fetch_post, only: [:show, :edit, :update]
  before_action :set_section

  def index
    @meta  = { keywords: Post.meta_tags, description: Post.meta_desc }

    @posts = Post
      .published
      .page(params[:page])
      .per_page(5)
      .for_year(params[:year])
      .order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @page_title = @post.title
    @meta       = { keywords: @post.tag_list, description: Array(@post.meta) }
    @comment    = Comment.new(commentable_id: @post.id, commentable_type: 'Post')
    @comments   = @post.comments.approved
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def set_section
    @section = 'blog'
  end

  def post_params
    params
      .require(:post)
      .permite(:title, :body, :path, :meta, :published, :truncate_length)
  end

  def fetch_post
    @post = Post.find_by!(path: params[:id])
  end
end
