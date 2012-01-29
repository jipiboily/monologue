module Monologue
  module ApplicationHelper
    def monologue_admin_form_for(object, options = {}, &block)
      options[:builder] = MonologueAdminFormBuilder
      form_for(object, options, &block)
    end
  end
end
