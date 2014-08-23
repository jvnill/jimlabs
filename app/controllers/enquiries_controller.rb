class EnquiriesController < ApplicationController
  before_action :set_section

  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      Notifier.contact_us(@enquiry).deliver
      redirect_to '/contact', notice: 'Thank you for your enquiry!!'
    else
      render :new
    end
  end

  private

  def set_section
    @section = 'contactus'
  end

  def enquiry_params
    params.require(:enquiry).permit(:message, :name, :email, :company)
  end
end
