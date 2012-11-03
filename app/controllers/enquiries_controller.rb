class EnquiriesController < ApplicationController
  before_filter :set_section
  skip_before_filter :login_required, :only => [:new, :create]

  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = Enquiry.new params[:enquiry]

    if @enquiry.save
      Notifier.contact_us(@enquiry).deliver
      redirect_to '/contact', notice: 'Thank you for your enquiry!!'
    else
      render :new
    end
  end

  def destroy
  end

  private
  def set_section
    @section = 'contactus'
  end
end
