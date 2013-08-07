require 'spec_helper'
describe "tag cloud" do
  after do
    clear_cache
  end

  describe "Viewing the tag cloud" do

    before(:each) do
      Factory(:post_with_tags)
      post = Factory(:posts_revision, title: "Future post", published_at: DateTime.new(3000)).post
      post.tag!(["Rails", "another tag"])
    end

    it "should not display tags that are referenced by posts in the future" do
      visit "/monologue"
      page.should_not have_content("another tag")
    end

    it "should display tags that are referenced by published posts" do
      visit "/monologue"
      page.should have_content("Rails")
    end

  end
end