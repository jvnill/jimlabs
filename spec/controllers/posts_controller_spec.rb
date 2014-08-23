require 'rails_helper'

describe PostsController do
  describe 'GET index' do
    let!(:post) { create(:post) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:posts).to_a).to eql([post]) }
  end

  describe 'GET new' do
    include_context 'user logged in'

    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:post)).to be_new_record }
  end

  describe 'POST create' do
    include_context 'user logged in'

    context 'valid post' do
      before { post :create, post: attributes_for(:post) }

      it { expect(response).to redirect_to(post_path(assigns(:post))) }
      it { expect(assigns(:post)).to be_persisted }
    end

    context 'invalid post' do
      before { post :create, post: attributes_for(:post).merge(title: '') }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
      it { expect(assigns(:post)).to be_new_record }
    end
  end

  describe 'GET show' do
    let!(:post) { create(:post) }

    before { get :show, id: post.path }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:show) }
    it { expect(assigns(:meta)).to eql(keywords: post.tag_list, description: [post.meta]) }
  end

  describe 'GET edit' do
    include_context 'user logged in'

    let!(:post) { create(:post) }

    before { get :edit, id: post.path }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:post)).to eql(post) }
  end

  describe 'PUT update' do
    include_context 'user logged in'

    let!(:post) { create(:post) }

    context 'valid update' do
      before { put :update, id: post.path, post: { title: 'new title' } }

      it { expect(response).to redirect_to(post_path(post)) }
      it { expect(assigns(:post).title).to eql('new title') }
    end

    context 'invalid update' do
      before { put :update, id: post.path, post: { title: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:edit) }
      it { expect(assigns(:post).title).to eql('') }
    end
  end
end
