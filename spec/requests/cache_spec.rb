# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  before(:each) do
    user = Factory(:user)
    posts = 0
    published_at = DateTime.now - 30.days
    25.times do
      revisions = 0
      posts+=1
      @post = Factory(:post)
      3.times do 
        revisions += 1
        published_at = published_at + 1.day
        @post.posts_revisions.build(Factory.attributes_for(:posts_revision, user_id: user.id, url: "/monologue/post/#{posts}" , title: "post #{posts} | revision #{revisions}", published_at: published_at ))
      end
      @post.save
    end

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
      @test_paths = ["/monologue", "/monologue/post/2", "/monologue/post/3"]
      @test_paths.each do |path|
        assert_create_cache(path)
      end
      assert_create_cache(feed_path,nil,"rss")
    end

    it "should clear cache on create" do
      post = Factory(:post)
      cache_sweeped?(["/monologue"]).should be_true
      cache_sweeped?(["/monologue/post/2", "/monologue/post/3"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on update" do
      @post.save!
      cache_sweeped?([@post.latest_revision.url]).should be_true
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?(["/monologue/post/2", "/monologue/post/3"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on destroy" do
      @post.destroy
      cache_sweeped?(["/monologue/"]).should be_true
      cache_sweeped?(["/monologue/post/2", "/monologue/post/3"]).should be_false
      cache_sweeped?([feed_path], "rss").should be_true
    end
  end
end