shared_context 'user logged in' do
  before { allow(controller).to receive(:login_required).and_return(true) }
end
