require 'spec_helper'
describe "tag category" do
  after do
    clear_cache
  end

  describe "Viewing the tag category" do

    before(:each) do
      Factory(:post_with_tags)
      post = Factory(:post, title: "Future post", published_at: DateTime.new(3000))
      post.tag!(["rails", "another tag"])
    end

    it "should only display the frequency of tags used by published post" do
      visit "/monologue"
      page.should have_content("rails (1)")
    end

  end
end