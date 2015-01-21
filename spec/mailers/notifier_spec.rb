require 'rails_helper'

describe Notifier do
  describe 'contact_us' do
    let!(:enquiry) { create(:enquiry) }

    before { Notifier.contact_us(enquiry).deliver_now }

    it { expect(ActionMailer::Base.deliveries.first.subject).to eql('[Jimlabs] Contact Us') }
  end
end
