class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :debug_flag

  def debug_flag
    unless params[:debug].nil? then
      session[:debug] = params[:debug]
    end
    session[:debug]
  end
end
