module Monologue
  module ControllerHelpers
    module User
      def self.included(base)
        base.class_eval do
          helper_method :monologue_current_user
        end
      end

      private
      def monologue_current_user
        @monologue_current_user ||= Monologue::User.find(session[:monologue_user_id]) if session[:monologue_user_id]
      end
    end
  end
end