# encoding: UTF-8
require 'spec_helper'
describe "Monologue::TotalSweeper" do
  before do
    ActionController::Base.perform_caching = true
    Monologue::PageCache.enabled = true
    Monologue::PageCache.wipe_enabled = true
    ActionController::Base.page_cache_directory = Rails.public_path + "/my-cache-dir"

    @post_1 = Factory(:posts_revision).post
    @post_2 = Factory(:posts_revision).post
    FileUtils.mkdir_p("#{ActionController::Base.page_cache_directory}/monologue/post")
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_1.active_revision.url}.html"
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_2.active_revision.url}.html"
  end

  after do
    FileUtils.rm_rf(Dir.glob("#{Rails.public_path}/my-cache-dir/*"))
    FileUtils.rm_rf(Dir.glob("#{Rails.public_path}/monologue/*"))
  end

  it "wipe if all config is set correctly" do
    Monologue::TotalSweeper.wipe_all
    Dir["#{ActionController::Base.page_cache_directory}/**/*"].length.should eq 0
  end

  it "do NOT wipe unless ActionController::Base.perform_caching" do
    ActionController::Base.perform_caching = false
    Monologue::TotalSweeper.wipe_all
    Dir["#{ActionController::Base.page_cache_directory}/**/*"].length.should eq 4
  end

  it "do NOT wipe unless Monologue::PageCache.enabled" do
    ActionController::Base.perform_caching = false
    Monologue::TotalSweeper.wipe_all
    Dir["#{ActionController::Base.page_cache_directory}/**/*"].length.should eq 4
  end

  it "do NOT wipe if public ActionController::Base.page_cache_directory == Rails.public_path" do
    ActionController::Base.page_cache_directory = Rails.public_path
    FileUtils.mkdir_p("#{ActionController::Base.page_cache_directory}/monologue/post")
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_1.active_revision.url}.html"
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_2.active_revision.url}.html"
    Monologue::TotalSweeper.wipe_all
    Dir["#{ActionController::Base.page_cache_directory}/monologue/**/*"].length.should eq 3
  end

  it "do NOT wipe unless Monologue::PageCache.wipe_enabled" do
    Monologue::PageCache.wipe_enabled = nil
    Monologue::TotalSweeper.wipe_all
    Dir["#{ActionController::Base.page_cache_directory}/**/*"].length.should eq 4
  end
end
