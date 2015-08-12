# encoding: UTF-8
require 'spec_helper'
describe "feed" do
  before(:each) do
    Factory(:post, url: "url/to/post")
  end

  # test to prevent regression for issue #72
  it "should contain full" do
    visit feed_path
    page.should have_content "/monologue/url/to/post"
  end

  context "with tags param" do
    before do
      create(:post, title: "Feed Post").tag!(["feed"])
      create(:post, title: "Rss Post").tag!(["rss"])
    end

    context "with tags" do
      it "returns posts tagged with tags" do
        visit feed_path(tags: "feed,rss")
        page.should have_content "Feed Post"
        page.should have_content "Rss Post"
      end
    end

    context "without tags" do
      it "returns all posts" do
        visit feed_path(tags: "")
        page.should have_content "Feed Post"
        page.should have_content "Rss Post"
      end
    end
  end
end