# encoding: UTF-8
ActionController::Base.public_class_method :page_cache_path

class String
  def is_page_cached? format = nil
    file = format.nil? ? self : "#{self}.#{format}"
    File.exists? ActionController::Base.page_cache_path(file)
  end
end

module ResponseHelper
  def page_cached?(request, format = nil)
    request.path.is_page_cached? format
  end
end

module CacheHelper
  def cache_sweeped?(path_array, format = nil)
    path_array.each do |path|
      path = path.chomp("/")
      path = "#{path}.#{format}" unless format.nil?
      return false if File.exists? ActionController::Base.page_cache_path(path)
    end
  end

  def assert_create_cache(path, content = nil, format = nil)
    path.is_page_cached?.should be_false
    get path
    response.status.should be(200)
    response.body.should have_content(content) unless content.nil?
    response.should be_page_cached(request, format)
  end

  def clear_cache
    show_cache_dir = "#{Rails.root}/public/monologue"
    index_cache_file = "#{show_cache_dir}.html"
    FileUtils.rm_rf "#{Rails.root}/tmp/cache"
    FileUtils.rm_rf show_cache_dir
    FileUtils.rm index_cache_file, force: true
  end
end

ActionDispatch::TestResponse.send(:include, ResponseHelper)

RSpec.configure do |c|
  c.include CacheHelper, type: :request
end