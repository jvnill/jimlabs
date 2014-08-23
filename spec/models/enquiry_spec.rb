require 'rails_helper'

describe Enquiry do
  describe '#name_format' do
    let!(:enquiry) { Enquiry.new(name: '123', email: 'jim@example.com', message: 'Message') }

    before { enquiry.valid? }

    it { expect(enquiry.errors[:name]).to eql(['must only contain letters and spaces']) }
  end
end
