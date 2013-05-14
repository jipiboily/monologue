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
end