require 'spec_helper'
describe "tags" do

  after do
    clear_cache
  end

  describe "Viewing the list of posts with tags" do
    before(:each) do
      Factory(:post_with_tags, title: "post X")
    end

    it "should display the tags for the posts as a link" do
      visit "/monologue"
      page.should have_link("rails")
      page.should have_link("a great tag")
    end
  end

  describe "filtering by a given tag" do
    before(:each) do
      @post = Factory(:post_with_tags, title: "post X")
      Factory(:post, title: "post Z")
    end

    it "should only display posts with the given tag" do
      visit "/monologue"
      page.should have_content("post Z")
      click_on "rails"
      find(".content").should have_content("post X")
      find(".content").should_not have_content("post Z")
    end

    it "should not display posts with tags with future publication date" do
      post = Factory(:post, title: "we need to reach 88 miles per hour", published_at: DateTime.new(3000))
      post.tag!(["rails","another tag"])
      visit "/monologue"
      click_on "rails"
      page.should have_content("post X")
      page.should_not have_content("we need to reach 88 miles per hour")
    end
  end
end