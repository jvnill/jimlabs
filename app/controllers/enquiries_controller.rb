class EnquiriesController < ApplicationController
  before_filter :set_section
  skip_before_filter :login_required, :only => [:new, :create]

  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = Enquiry.new params[:enquiry]

    if @enquiry.save
      Notifier.deliver_contact_us(@enquiry)
      render :text => '<center style="margin-top:110px;font-size:15px"> I\'ll get back to you as soon as I can.<br><br>Thank you!</center>', :layout => true
    else
      render :action => :new
    end
  end

  def destroy
  end

  private
  def set_section
    @section = 'contactus'
  end
end
