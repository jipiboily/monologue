# encoding: UTF-8
ActionController::Base.public_class_method :page_cache_path

class String
  def is_page_cached? extension = nil
    file = extension.nil? ? self : "#{self}.#{extension}"
    File.exists? ActionController::Base.page_cache_path(file)
  end
end

module ResponseHelper
  def page_cached?(request, extension = nil)
    request.path.is_page_cached? extension
  end
end

module CacheHelper
  def cache_sweeped?(path_array, extension = nil)
    path_array.each do |path|
      return false if path.chomp("/").is_page_cached?(extension) == true
    end
  end

  def assert_create_cache(path, content = nil, extension = nil)
    path.is_page_cached?.should be_false
    get path
    response.status.should be(200)
    response.body.should have_content(content) unless content.nil?
    response.should be_page_cached(request, extension)
  end

  def clear_cache
    show_cache_dir = "#{Rails.root}/public/monologue"
    index_cache_file = "#{show_cache_dir}.html"
    FileUtils.rm_rf show_cache_dir
    FileUtils.rm index_cache_file, :force => true
  end
end

ActionDispatch::TestResponse.send(:include, ResponseHelper)

RSpec.configure do |c|
  c.include CacheHelper, :type => :request
end