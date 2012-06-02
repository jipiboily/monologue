require 'spec_helper'
describe "tags" do

  after do
    clear_cache
  end

  describe "Viewing the list of posts with tags" do
    before(:each) do
      Factory(:post_with_tags)
    end

    it "should display the tags for the posts as a link" do
      visit "/monologue"
      page.should have_link("rails")
      page.should have_link("a great tag")
    end
  end

  describe "filtering by a given tag" do
    before(:each) do
      Factory(:post_with_tags)
      Factory(:posts_revision, :title => "post Z")
    end

    it "it should only display posts with the given tag" do
      visit "/monologue"
      page.should have_content("post Z")
      click_on "rails"
      page.should have_content("post X | revision 2")
      page.should_not have_content("post Z")
    end
  end
end


