require 'rails_helper'

describe PagesController do
  describe 'GET index' do
    let!(:portfolio) { create(:portfolio) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:meta)).to match(hash_including(:keywords, :description)) }
    it { expect(assigns(:portfolios).to_a).to eql([portfolio]) }
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
