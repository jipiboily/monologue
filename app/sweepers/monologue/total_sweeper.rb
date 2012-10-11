class Monologue::TotalSweeper
  def self.wipe_all
    FileUtils.rm_rf(Dir.glob("#{ActionController::Base.page_cache_directory}/*")) if ActionController::Base.perform_caching && Monologue::PageCache.enabled && Monologue::PageCache.wipe_enabled && (ActionController::Base.page_cache_directory != Rails.public_path)
  end
end