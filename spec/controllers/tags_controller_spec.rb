require 'rails_helper'

describe TagsController do
  describe 'GET show' do
    before { get :show, tag_name: 'cute' }

    it { expect(response).to be_success }
  end
end
