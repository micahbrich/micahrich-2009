class CommentMailer < ActionMailer::Base

  def micah_notifier(comment)
    recipients  "micah@micahrich.com"
    from        '<micah takes photos> blog@micahrich.com'
    subject     "a new comment on your blog!"
    body        :comment => comment
  end
  

  def comment_notifier(reciever, comment)
    recipients  reciever.email
    from        '<micah takes photos> blog@micahrich.com'
    subject     "a new comment on micah's blog!"
    body        :comment => comment
  end
end
