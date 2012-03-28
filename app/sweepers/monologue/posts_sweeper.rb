class Monologue::PostsSweeper < ActionController::Caching::Sweeper
  observe Monologue::Post


  def sweep(post)
    all_monologue_cache_dir = ActionController::Base.page_cache_path('/monologue/').gsub(".html","")
    FileUtils.rm_rf ActionController::Base.page_cache_path('/monologue/')
    FileUtils.rm_rf all_monologue_cache_dir
  end

  alias_method :after_create, :sweep 
  alias_method :after_update, :sweep 
  alias_method :after_destroy, :sweep

end