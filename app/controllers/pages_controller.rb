class PagesController < ApplicationController
  skip_before_filter :login_required

  def index
    @section = 'home'
    @meta    = {
      :keywords => 'Jim Ruther Nill, blog, portfolio, Jimlabs, Ruby on Rails',
      :description => 'Jimlabs: Jim Ruther Nill\'s Ruby on Rails blog and portfolio'
    }
    @developer = File.read File.join(Rails.root, 'lib', 'frontpage', 'developer.html')
    @me        = File.read File.join(Rails.root, 'lib', 'frontpage', 'me.html')
    @skillset  = File.read File.join(Rails.root, 'lib', 'frontpage', 'skillset.html')
  end

  def sitemap
    @posts      = Post.published
    @portfolios = Portfolio.published
  end

  def page_not_found
    @page_title = '404: Page Not Found'
    @no_sidebar = true
  end
end
