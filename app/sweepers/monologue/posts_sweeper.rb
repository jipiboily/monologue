class Monologue::PostsSweeper < ActionController::Caching::Sweeper
  observe Monologue::Post

  def sweep(post)
    if ActionController::Base.perform_caching && Monologue::PageCache.enabled && Monologue::PageCache.wipe_enabled && Monologue::PageCache.wipe_after_save && (ActionController::Base.page_cache_directory != Rails.public_path)
      Monologue::TotalSweeper.wipe_all
    else
      sweep_for_single_post post
    end
  end

  def sweep_for_single_post post
    return unless post.published
    root_path = Monologue::Engine.routes.url_helpers.root_path if root_path.nil? # TODO: why do I have to do this to make tests pass? There must be something much more clean to make tests pass
    page_cache_directory = Rails.public_path if page_cache_directory.nil? # TODO: we should not need this either...

    # post
    if post.posts_revisions.count > 0
      current_post_path = "#{page_cache_directory}#{root_path}#{post.just_the_revision_one_before.url}.html" unless post.just_the_revision_one_before.nil?
      current_post_path = "#{page_cache_directory}#{root_path}#{post.posts_revisions.last.url}.html" if post.posts_revisions.count == 1
      File.delete current_post_path if File.exists? current_post_path
    end

    # tags
    tags_path = "#{page_cache_directory}#{root_path}tags"
    FileUtils.rm_rf tags_path

    # feed
    feed_file_path = "#{page_cache_directory}#{root_path}feed.rss"
    File.delete feed_file_path if File.exists? feed_file_path

    # root
    root_file_path = "#{page_cache_directory}#{root_path.chomp("/")}.html"
    root_file_path = "#{page_cache_directory}/index.html" if root_path.chomp("/") == "" # TODO: add test for that? It would need another dummy app mounted at root...?
    File.delete root_file_path if File.exists? root_file_path

    # paging
    FileUtils.rm_rf "#{page_cache_directory}/page" # remove pages
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep

end