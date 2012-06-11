module Monologue
  module ApplicationHelper
    #NUMBER_OF_LABEL_SIZES = 5

    def monologue_admin_form_for(object, options = {}, &block)
      options[:builder] = MonologueAdminFormBuilder
      form_for(object, options, &block)
    end

    def monologue_accurate_title
      content_for?(:title) ? ((content_for :title) + " | #{Monologue.site_name}") : Monologue.site_name
    end


    def sidebar_section_for(title, &block)
      content_tag(:section, :class => 'widget') do
        content_tag(:header,content_tag(:h3,title)) +
        capture(&block)
      end
    end

    def tag_url(tag)
      "#{Monologue::Engine.routes.url_helpers.root_path}tags/#{tag.name}"
    end

    def size_for_tag(tag,min,max)
      #logarithmic scaling based on the number of occurrences of each tag
      #we have defined 5 sizes in the CSS hence 5
      min<max ? 1 + ((5 -1)*(log_distance_to_min(tag.frequency, min))/log_distance_to_min(max, min)).round : 1
    end

  private
    def log_distance_to_min(value, min)
      Math.log(value)-Math.log(min)
    end
  end
end
