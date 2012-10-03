namespace :monologue do
  namespace :cache do
    desc "Completely wipe Monologue's cache"
    task :wipe => :environment do
      puts "********************************************************************************"
      puts "**********       Monologue, your blogging engine: rake edition      ************"
      puts "********************************************************************************"
      puts "  Starting to run 'rake monologue:cache:wipe'... "
      if ActionController::Base.perform_caching && Monologue::PageCache.enabled && Monologue::PageCache.wipe_enabled && (ActionController::Base.page_cache_directory != Rails.public_path)
        puts "  Starting to wipe cache...hold tight..."
        Monologue::TotalSweeper.wipe_all
        puts "  \e[#{32}mDone!\e[0m"
      else
        msg = "  Monologue's cache configuration isn't set correctly to use this wipe task. Doc here: https://github.com/jipiboily/monologue/wiki/Configure-Monologue's-cache"
        puts "\e[#{31}m#{msg}\e[0m"
        puts "  Current configuration: "
        puts "  ActionController::Base.perform_caching == #{ActionController::Base.perform_caching}"
        puts "  Monologue::PageCache.enabled == #{Monologue::PageCache.enabled}"
        puts "  Monologue::PageCache.wipe_enabled == #{Monologue::PageCache.wipe_enabled}"
        puts "  ActionController::Base.page_cache_directory == #{ActionController::Base.page_cache_directory}"
        puts "  Rails.public_path == #{Rails.public_path}"
      end
      puts "********************************************************************************"
    end
  end
end