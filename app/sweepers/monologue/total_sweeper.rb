class Monologue::TotalSweeper
  def self.wipe_all
    FileUtils.rm_rf(Dir.glob("#{ActionController::Base.page_cache_directory}/*"))
  end
end