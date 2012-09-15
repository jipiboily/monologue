# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  before(:each) do
    @post_1 = Factory(:posts_revision).post
    @post_2 = Factory(:posts_revision).post
    @post_3 = Factory(:posts_revision).post
    25.times { |i| Factory(:posts_revision, :title => "post #{i}", :url => "post/#{i*100}") }
    ActionController::Base.perform_caching = true
    clear_cache
  end

  after do
    ActionController::Base.perform_caching = false
    clear_cache
  end

  describe "creates" do
    it "post's index cache" do
      assert_create_cache("/monologue", "post 22")
    end

    it "post's show cache" do
      assert_create_cache("/monologue/post/200", "post 2")
    end

    it "feed cache" do
      assert_create_cache(feed_path, "post 22", "rss")
    end
  end

  describe "sweeper" do
    before(:each) do
      @test_paths = ["/monologue","/monologue/#{@post_1.active_revision.url}", "/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]
      @test_paths.each do |path|
        assert_create_cache(path)
      end
      assert_create_cache(feed_path,nil,"rss")
    end

    it "should clear cache on create" do
      post = Factory(:post)
      cache_sweeped?(["/monologue"]).should be_true
      cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on update" do
      @post_1.save!
      cache_sweeped?(["/monologue/#{@post_1.active_revision.url}"]).should be_true
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on destroy" do
      @post_1.destroy
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "won't clean cache if saving a not yet published post" do
      @post_1.published = false
      @post_1.save!
      cache_sweeped?(["/monologue/#{@post_1.active_revision.url}"]).should be_false
      cache_sweeped?(["/monologue/"]).should be_false
      cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_false
    end

  end

  context "admin" do
    it "should display a warning after saving a post published at a future date when cache is ON" do
      ActionController::Base.perform_caching = true
      log_in
      visit new_admin_post_path
      fill_in "Title", :with =>  "my title"
      fill_in "Content", :with =>  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
      fill_in "Published at", :with =>  DateTime.now + 2.days
      check "Published"
      click_button "Save"
      page.should have_content I18n.t("monologue.admin.posts.create.created_with_future_date_and_cache")
      click_button "Save"
      page.should have_content I18n.t("monologue.admin.posts.update.saved_with_future_date_and_cache")
    end

    it "should NOT display a warning after saving a post published at a future date when cache is OFF" do
      ActionController::Base.perform_caching = false
      log_in
      visit new_admin_post_path
      fill_in "Title", :with =>  "my title"
      fill_in "Content", :with =>  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
      fill_in "Published at", :with =>  DateTime.now + 2.days
      check "Published"
      click_button "Save"
      page.should have_content I18n.t("monologue.admin.posts.create.created")
      click_button "Save"
      page.should have_content I18n.t("monologue.admin.posts.update.saved")
    end
  end
end