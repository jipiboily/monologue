require 'spec_helper'
describe "archive" do
  before(:each) do
    Factory(:post, title: "post X")
  end

  it "lists archived posts" do
    visit "/monologue"
    within(".sidebar") do
      page.should have_content("post X")
    end
  end
end