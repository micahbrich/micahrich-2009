# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c132ccba0e489740b5c45864875bc989'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :get_api_user_and_set
  
  def get_api_user_and_set
    Fleakr.api_key = APP_CONFIG['api_key']
    @user = Fleakr.user(APP_CONFIG['user_email'])
    @user.sets.each do |set|
      if set.title == APP_CONFIG['photoset']
        @set = set
      end
    end
  end
end
