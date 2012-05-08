# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  before(:each) do
    @post_1 = Factory(:posts_revision).post
    @post_2 = Factory(:posts_revision).post
    @post_3 = Factory(:posts_revision).post
    25.times { |i| Factory(:posts_revision, :title => "post #{i}", :url => "/monologue/post/#{i}") }
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
      assert_create_cache("/monologue/post/2", "post 2")
    end

    it "feed cache" do
      assert_create_cache(feed_path, "post 22", "rss")
    end
  end

  describe "sweeper" do 
    before(:each) do
      @test_paths = ["/monologue", @post_1.latest_revision.url, @post_2.latest_revision.url, @post_3.latest_revision.url]
      @test_paths.each do |path|
        assert_create_cache(path)
      end
      assert_create_cache(feed_path,nil,"rss")
    end

    it "should clear cache on create" do
      post = Factory(:post)
      cache_sweeped?(["/monologue"]).should be_true
      cache_sweeped?([@post_2.latest_revision.url, @post_3.latest_revision.url]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end 

    it "should clear cache on update" do
      @post_1.save!
      cache_sweeped?([@post_1.latest_revision.url]).should be_true
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?([@post_2.latest_revision.url, @post_3.latest_revision.url]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on destroy" do
      @post_1.destroy
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?([@post_2.latest_revision.url, @post_3.latest_revision.url]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "won't clean cache if saving a not yet published post" do
      @post_1.published = false
      @post_1.save!
      cache_sweeped?([@post_1.latest_revision.url]).should be_false
      cache_sweeped?(["/monologue/"]).should be_false
      cache_sweeped?([@post_2.latest_revision.url, @post_3.latest_revision.url]).should be_false
      cache_sweeped?([feed_path], "rss").should be_false
    end
  end
end