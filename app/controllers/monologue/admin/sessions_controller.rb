module Monologue
  module Admin
    class SessionsController < BaseController
      skip_before_filter :authenticate_user!
      
      def new
      end
  
      def create
        user = Monologue::User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to admin_url, :notice => "Logged in!"
        else
          flash.now.alert = "Invalid email or password"
          render "new"
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to admin_url, :notice => "Logged out!"
      end
    end
  end
end
