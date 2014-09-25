require 'rails_helper'

describe Portfolio do
  describe 'image_url' do
    it { expect(Portfolio.new(identifier: 'id').image_url('thumb')).to eql("https://dl.dropboxusercontent.com/u/32173582/jimlabs/thumb/id.png") }
  end
end
