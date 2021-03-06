# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# care if the mailer can't send
config.action_mailer.raise_delivery_errors = true

#delivery method
# config.action_mailer.delivery_method = :smtp
# ActionMailer::Base.delivery_method = :activerecord

# smtp settings
# config.action_mailer.smtp_settings = {
#   # :address          => 'smtp.micahrich.com',
#   :address          => 'localhost',
#   :port             => 25,
#   :authentication => :login,
#   :domain           => 'micahrich.com',
#   :user_name        => 'info+micahrich.com',
#   :password         => 'russell'
# }