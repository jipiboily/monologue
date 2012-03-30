class Monologue::PostsSweeper < ActionController::Caching::Sweeper
  observe Monologue::Post


  def sweep(post)
    root_path = Monologue::Engine.routes.url_helpers.root_path if root_path.nil? # TODO: why do I have to do this to make tests pass? There must be something much more clean to make tests pass
    page_cache_directory = Rails.public_path if page_cache_directory.nil? # TODO: we should not need this either...
    all_monologue_cache_dir =  "#{page_cache_directory}#{root_path}"
    FileUtils.rm_rf "#{page_cache_directory}#{root_path.chomp("/")}.html"
    FileUtils.rm_rf all_monologue_cache_dir
  end

  alias_method :after_create, :sweep 
  alias_method :after_update, :sweep 
  alias_method :after_destroy, :sweep

end