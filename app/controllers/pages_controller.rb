class PagesController < ApplicationController
  def index
    @section = 'home'
    @meta    = {
      keywords: ['Jim Ruther Nill', 'blog', 'portfolio', 'Jimlabs', 'Ruby on Rails'],
      description: ["Jimlabs: Jim Ruther Nill\'s Ruby on Rails blog and portfolio"]
    }

    @me        = File.read(Rails.root.join('lib', 'frontpage', 'me.html'))
    @skillset  = File.read(Rails.root.join('lib', 'frontpage', 'skillset.html'))
  end

  def sitemap
    @posts      = Post.published
    @portfolios = Portfolio.all
  end

  def page_not_found
    @page_title = '404: Page Not Found'

    respond_to do |format|
      format.html
    end
  end
end
