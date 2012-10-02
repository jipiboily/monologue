class Monologue::Admin::CacheController < Monologue::Admin::BaseController
  def show
    @wipe_after_save = Monologue::PageCache.wipe_after_save
    # puts "ActionController::Base.perform_caching #{ActionController::Base.perform_caching}"
    # puts "Monologue::PageCache.enabled #{Monologue::PageCache.enabled}"
    # puts "Monologue::PageCache.wipe_enabled #{Monologue::PageCache.wipe_enabled}"
    # puts "ActionController::Base.page_cache_directory #{ActionController::Base.page_cache_directory} || Rails.public_path #{Rails.public_path}"
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
end