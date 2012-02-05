class Monologue::ApplicationController < ApplicationController
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  
  private

    def current_user
      @current_user ||= Monologue::User.find(session[:user_id]) if session[:user_id]
    end
  
  helper_method :current_user
end
