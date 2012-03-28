# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  before(:each) do
    user = Factory(:user)
    posts = 0
    25.times do
      revisions = 0
      posts+=1
      @post = Factory(:post)
      3.times do 
        revisions+=1
        @post.posts_revisions.build(Factory.attributes_for(:posts_revision, user_id: user.id, url: "/monologue/post/#{posts}" , title: "post #{posts} | revision #{revisions}"))
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

  describe "cache creation" do
    it "creates post's index cache" do
      assert_create_cache(root_path, "post 2")
    end

    it "creates post's show cache" do
      assert_create_cache("/monologue/post/2", "post 2")
    end

    it "creates feed cache" do
      assert_create_cache(feed_path, "post 2", "rss")
    end
  end

  describe "cache sweeping" do 
    before(:each) do
      @test_paths = [root_path, "/monologue/post/2", "/monologue/post/3"]
      @test_paths.each do |path|
        assert_create_cache(path)
      end
      assert_create_cache(feed_path,nil,"rss")
    end

    it "should clear cache on create" do
      post = Factory(:post)
      cache_sweeped?(@test_paths).should be_true
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on update" do
      @post.save!
      cache_sweeped?(@test_paths).should be_true
      cache_sweeped?([feed_path], "rss").should be_true
    end

    it "should clear cache on destroy" do
      @post.destroy
      cache_sweeped?(@test_paths).should be_true
      cache_sweeped?([feed_path], "rss").should be_true
    end
  end
end