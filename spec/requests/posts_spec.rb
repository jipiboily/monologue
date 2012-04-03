require 'spec_helper'
describe "posts" do
  before(:each) do
    Factory(:post_with_multiple_revisions)
  end
  
  it "lists posts" do
    visit "/monologue"

    page.should have_content("post X | revision 2")
    page.should_not have_content("post X | revision 1")
  end
  
  it "should route to a post" do
    visit "/monologue"
    click_on "post X | revision 2"
    page.should have_content("this is some text with french accents")
    page.should_not have_content("post X | revision 1")
  end
  
  it "has a feed" do
    visit feed_path
    page.should_not have_content("post X | revision 1")
    page.should have_content("post X | revision 2")
  end
  
  it "should return 404 on non existent post" do
    lambda {
      visit "/monologue/this/is/a/404/url"
    }.should raise_error(ActionController::RoutingError)
  end
end