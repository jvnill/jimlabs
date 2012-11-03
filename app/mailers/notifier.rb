class Notifier < ActionMailer::Base
  default from: 'Jimlabs',
    to: 'jvnill@gmail.com',
    date: Time.now,
    content_type: 'text/html'

  def new_comment(comment)
    @comment = comment
    mail subject: '[Jimlabs] New Comment'
  end

  def contact_us(enquiry)
    @enquiry = enquiry
    mail subject: '[Jimlabs] Contact Us'
  end
end
