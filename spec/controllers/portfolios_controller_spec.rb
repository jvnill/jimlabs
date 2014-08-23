require 'rails_helper'

describe PortfoliosController do
  describe 'GET index' do
    let!(:portfolio) { create(:portfolio) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:portfolios).to_a).to eql([portfolio]) }
  end

  describe 'GET new' do
    include_context 'user logged in'

    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:portfolio)).to be_new_record }
  end

  describe 'POST create' do
    include_context 'user logged in'

    context 'valid portfolio' do
      before { post :create, portfolio: attributes_for(:portfolio) }

      it { expect(response).to redirect_to(portfolio_index_path) }
      it { expect(assigns(:portfolio)).to be_persisted }
    end

    context 'invalid portfolio' do
      before { post :create, portfolio: attributes_for(:portfolio).merge(title: '') }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
      it { expect(assigns(:portfolio)).to be_new_record }
    end
  end

  describe 'GET edit' do
    include_context 'user logged in'

    let!(:portfolio) { create(:portfolio) }

    before { get :edit, id: portfolio.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:portfolio)).to eql(portfolio) }
  end

  describe 'PUT update' do
    include_context 'user logged in'

    let!(:portfolio) { create(:portfolio) }

    context 'valid update' do
      before { put :update, id: portfolio.id, portfolio: { title: 'new title' } }

      it { expect(response).to redirect_to(portfolio_index_path) }
      it { expect(assigns(:portfolio).title).to eql('new title') }
    end

    context 'invalid update' do
      before { put :update, id: portfolio.id, portfolio: { title: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:edit) }
      it { expect(assigns(:portfolio).title).to eql('') }
    end
  end

  describe 'DELETE destroy' do
    include_context 'user logged in'

    let!(:portfolio) { create(:portfolio) }

    before { delete :destroy, id: portfolio.id }

    it { expect(response).to redirect_to(portfolio_index_path) }
    it { expect(assigns(:portfolio)).to_not be_persisted }
  end
end
