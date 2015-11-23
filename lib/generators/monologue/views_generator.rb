require "rails/generators/base"

module Monologue
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc "Copies Monologue views to your application."
      argument :scope, required: false, default: nil,
                       desc: "The scope to copy views to"
      source_root File.expand_path("../../../../app/views", __FILE__)

      def copy_views
        view_directory :layouts
        view_directory :monologue
      end

      protected

      def view_directory(name)
        directory name.to_s, "#{target_path}/#{name}"
      end

      def target_path
        @target_path ||= "app/views/#{scope || ''}"
      end
    end
  end
end
