class EnquiriesController < ApplicationController
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      render nothing: true
      Notifier.contact_us(@enquiry).deliver
    else
      render json: @enquiry.errors, status: 400
    end
  end

  private

  def enquiry_params
    params.require(:enquiry).permit(:message, :name, :email, :company)
  end
end
