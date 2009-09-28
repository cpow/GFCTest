# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  
  
  before_filter :require_login
  
  def secure?
    false
  end

  def require_login
    if secure? && session[:user_id].nil?
      flash[:notice] = "you must be logged in!"
      redirect_to :controller => "users", :action => "login"
    end
  end
  
  layout "application"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
