# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  before do
    ActionController::Base.perform_caching = true
    Monologue::PageCache.enabled = true
    visit admin_path
    page.should have_content("You must first log in to access admin section.")
    @post_1 = Factory(:posts_revision).post
    @post_2 = Factory(:posts_revision).post
    FileUtils.mkdir_p("#{ActionController::Base.page_cache_directory}/monologue/post")
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_1.active_revision.url}.html"
    FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_2.active_revision.url}.html"
    log_in
  end

  after do
    clear_cache
  end

  context "fully enabled" do
    before do
      ActionController::Base.page_cache_directory = Rails.public_path  + "/my-cache-dir"
      Monologue::PageCache.wipe_enabled = true
      FileUtils.mkdir_p("#{ActionController::Base.page_cache_directory}/monologue/post")
      FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_1.active_revision.url}.html"
      FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_2.active_revision.url}.html"
    end

    it "has the possibility to completely wipe cache if wipe_enabled" do
      "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_true
      "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_true
      visit admin_cache_path
      click_link I18n.t("monologue.admin.cache.show.delete")
      page.should have_content(I18n.t("monologue.admin.cache.show.cache_wiped"))
      "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_false
      "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_false
    end

  end

  context "page_cache_directory == Rails.public_path" do
    before do
      ActionController::Base.page_cache_directory = Rails.public_path
      Monologue::PageCache.enabled = true
      FileUtils.mkdir_p("#{ActionController::Base.page_cache_directory}/monologue/post")
      FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_1.active_revision.url}.html"
      FileUtils.touch "#{ActionController::Base.page_cache_directory}/monologue/#{@post_2.active_revision.url}.html"
    end

    it "do NOT wipe cache" do
      @post_1.save!
      "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_false
      "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_true
    end

    it "will show help" do
      visit admin_cache_path
      page.should have_content(I18n.t("monologue.admin.cache.how_to_enable.warning"))
      page.should have_content(I18n.t("monologue.admin.cache.how_to_enable.explanations"))
    end
  end


  context "partially enabled" do
    it "has link to cache management" do
      Monologue::PageCache.enabled = nil
      visit admin_path
      page.should have_content(I18n.t("layouts.monologue.admin.nav_bar.cache"))
    end

    it "will show help to fully enable cache" do
      Monologue::PageCache.enabled = nil
      visit admin_cache_path
      page.should have_content(I18n.t("monologue.admin.cache.how_to_enable.warning"))
      page.should have_content(I18n.t("monologue.admin.cache.how_to_enable.explanations"))
    end
  end

  context "disabled" do
    it "do not enable cache management section" do
      ActionController::Base.perform_caching = false
      visit admin_path
      page.should_not have_content(I18n.t(".settings_menu.cache"))
    end
  end
end