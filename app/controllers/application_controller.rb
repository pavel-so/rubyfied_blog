
#TODO: roles implementation
#TODO: common design workaround
#TODO: testing
#TODO: cancan auth

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleAuth
  helper_method :logged_in?, :current_user
end

