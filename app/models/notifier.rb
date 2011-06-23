class Notifier < ActionMailer::Base
  def new_comment(comment)
    setup_email
    subject      '[Jimlabs] New Comment'
    body         :comment => comment
  end

  def contact_us(enquiry)
    setup_email
    subject      '[Jimlabs] Contact Us'
    body         :enquiry => enquiry
  end

  private
  def setup_email
    recipients   'jvnill@gmail.com'
    from         'Jimlabs'
    sent_on      Time.now
    content_type 'text/html'
  end
end
