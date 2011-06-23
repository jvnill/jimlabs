class CommentsController < ApplicationController
  skip_before_filter :login_required, :only => :create

  def create
    @comment = Comment.new(params[:comment])
    render :update do |page|
      if @comment.save
        page['comment_name'].value = ''
        page['comment_url'].value = ''
        page['comment_comment'].value = ''
        page.alert('Your comment will show as soon as the administrator approves it.  Thank you!')
        Notifier.deliver_new_comment(@comment)
      else
        page.alert("The following errors we're encountered:\n\n#{@comment.errors.full_messages.join("\n")}")
      end
    end
  end
end
