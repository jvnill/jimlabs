require 'rails_helper'

describe EnquiriesController do
  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:enquiry)).to be_new_record }
  end

  describe 'POST create' do
    context 'valid enquiry' do
      before do
        ActionMailer::Base.deliveries = []
        post :create, enquiry: { message: 'Msg', name: 'Jim', email: 'jim@example.com' }
      end

      it { expect(response).to redirect_to('/contact') }
      it { expect(flash[:notice]).to eql('Thank you for your enquiry!!') }
      it { expect(ActionMailer::Base.deliveries.size).to eql(1) }
    end

    context 'invalid enquiry' do
      before do
        ActionMailer::Base.deliveries = []
        post :create, enquiry: { message: '', name: 'Jim', email: 'jim@example.com' }
      end

      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
      it { expect(ActionMailer::Base.deliveries.size).to eql(0) }
    end
  end
end
