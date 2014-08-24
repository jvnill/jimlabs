require 'rails_helper'

describe ApplicationController do
  controller do
    before_action :login_required

    def index
      render plain: 'foo'
    end
  end

  describe 'login_required' do
    context 'failed auth' do
      before { get :index }

      it { expect(response.body).to match('HTTP Digest: Access denied.') }
    end

    context 'successful auth' do
      before do
        request.env['HTTP_AUTHORIZATION'] = 'asd'
        allow(ActionController::HttpAuthentication::Digest).to receive(:validate_digest_response).and_return(true)
        get :index
      end

      it { expect(response.body).to match('foo') }
    end
  end
end
