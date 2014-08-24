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
        request.env['HTTP_AUTHORIZATION'] = 'Digest realm="Application", opaque="foo", username="uname", response="response", uri="/"'
        request.env['DIGEST_USERNAME'] = 'uname'
        request.env['DIGEST_PASSWORD'] = 'pword'

        ApplicationController::USERS['uname'] = 'pword'

        allow(ActionController::HttpAuthentication::Digest).to receive(:validate_nonce).and_return(true)
        allow(ActionController::HttpAuthentication::Digest).to receive(:opaque).and_return('foo')
        allow(ActionController::HttpAuthentication::Digest).to receive(:expected_response).and_return('response')

        get :index
      end

      it { expect(response.body).to match('foo') }
    end
  end
end
