require 'rails_helper'

describe PagesController do
  describe 'GET index' do
    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:meta)).to match(hash_including(:keywords, :description)) }
    it { expect(assigns(:me)).to_not be_nil }
    it { expect(assigns(:skillset)).to_not be_nil }
  end

  describe 'GET sitemap' do
    before do
      allow(Post).to receive(:published).and_return('posts')
      allow(Portfolio).to receive(:all).and_return('portfolios')

      get :sitemap, format: :xml
    end

    it { expect(response).to be_success }
    it { expect(response).to render_template(:sitemap) }
    it { expect(assigns(:posts)).to eql('posts') }
    it { expect(assigns(:portfolios)).to eql('portfolios') }
  end
end
