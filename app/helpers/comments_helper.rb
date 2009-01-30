module CommentsHelper
  
  def check_comment_for_spam(author, text)
  @akismet = Akismet.new('9885f2de00ee', 'http://micahrich.com/blog/') # blog url: e.g. http://sas.sparklingstudios.com
  
    # return true when API key isn't valid, YOUR FAULT!!
    return true unless @akismet.verifyAPIKey 
    
    # will return false, when everthing is ok and true when Akismet thinks the comment is spam. 
    return @akismet.commentCheck(
              request.remote_ip,            # remote IP
              request.user_agent,           # user agent
              request.env['HTTP_REFERER'],  # http referer
              '',                           # permalink
              'comment',                    # comment type
              author,                       # author name
              '',                           # author email
              '',                           # author url
              text,                         # comment text
              {})                           # other
  end
  
end
