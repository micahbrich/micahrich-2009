class CommentMailer < ActionMailer::Base

  def micah_notifier

    
  end
  

  def comment_notifier(reciever, comment)
    recipients  reciever.email
    from        'info@micahrich.com'
    subject     "a new comment on micah's blog!"
    body        :comment => comment
  end
end
