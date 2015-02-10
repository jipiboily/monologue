require 'spec_helper'
describe "posts" do
  before(:each) do
    Factory(:post, title: "post X")
  end

  it "lists posts" do
    visit "/monologue"

    page.should have_content("post X")
  end

  it "should route to a post" do
    visit "/monologue"
    click_on "post X"
    page.should have_content("this is some text with french accents")
  end

  it "has a feed" do
    visit feed_path
    page.should have_content("post X")
  end

  it "should return 404 on non existent post" do
    visit "/monologue/this/is/a/404/url"
    page.should have_content("You may have mistyped the address or the page may have moved")
  end

  it "should not show post with published date in the future" do
    Factory(:post, published_at: DateTime.new(3000), title: "I am Marty McFly")
    visit root_path
    page.should_not have_content "I am Marty McFly"
  end

  it "should show published date with valid html5 timestamp" do
    Factory(:post, published_at: DateTime.new(2000), title: "Y2K", published: true)
    visit root_path
    page.should have_content "Y2K"
    page.should have_content "January 01, 2000"
    page.should_not have_css "time[datetime='2000-01-01 00:00:00 UTC']"
    page.should have_css "time[datetime='2000-01-01T00:00:00Z']"
  end
end
