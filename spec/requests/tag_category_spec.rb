require 'spec_helper'
describe "tag category" do
  describe "Viewing the tag category" do

    before(:each) do
      Factory(:post_with_tags)
      post = Factory(:post, title: "Future post", published_at: DateTime.new(3000))
      post.tag!(["Rails", "another tag"])
    end

    it "should only display the frequency of tags used by published post" do
      visit "/monologue"
      page.should have_content("Rails (1)")
    end

  end
end
