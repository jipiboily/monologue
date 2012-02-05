class Monologue::ApplicationController < ApplicationController
  
  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end
  
  
  private

    def current_user
      @current_user ||= Monologue::User.find(session[:user_id]) if session[:user_id]
    end
  
  helper_method :current_user
end
