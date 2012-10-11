class Monologue::Admin::CacheController < Monologue::Admin::BaseController
  before_filter :prepare_file_list

  def show
    if ActionController::Base.perform_caching && Monologue::PageCache.enabled && Monologue::PageCache.wipe_enabled &&  ActionController::Base.page_cache_directory != Rails.public_path
      render :show
    else
      render :how_to_enable
    end
  end

  def destroy
    Monologue::TotalSweeper.wipe_all
    flash.notice = I18n.t("monologue.admin.cache.show.cache_wiped")
    render :show
  end

  private
  def prepare_file_list
    @files = []
    Dir.glob("#{ActionController::Base.page_cache_directory}/**/*").each do |file|
      next if File.directory?(file)
      @files << file.gsub(ActionController::Base.page_cache_directory,"")
    end
    @files
  end
end