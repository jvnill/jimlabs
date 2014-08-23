require 'rails_helper'

describe 'page not found' do
  before { get '/foobar' }

  it { expect(response).to render_template(:page_not_found) }
end
