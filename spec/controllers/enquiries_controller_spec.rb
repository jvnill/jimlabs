require 'rails_helper'

describe EnquiriesController do
  describe 'POST create' do
    context 'valid enquiry' do
      before do
        ActionMailer::Base.deliveries = []
        post :create, enquiry: { message: 'Msg', name: 'Jim', email: 'jim@example.com' }
      end

      it { expect(response.body).to be_blank }
      it { expect(ActionMailer::Base.deliveries.size).to eql(1) }
    end

    context 'invalid enquiry' do
      before do
        ActionMailer::Base.deliveries = []
        post :create, enquiry: { message: '', name: 'Jim', email: 'jim@example.com' }
      end

      it { expect(response.body).to eql({ message: ['can\'t be blank'] }.to_json) }
      it { expect(ActionMailer::Base.deliveries.size).to eql(0) }
    end
  end
end
