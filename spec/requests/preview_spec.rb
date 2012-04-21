require 'spec_helper'
describe "preview" do
  before(:each) do
    @post_path = "/monologue/post/1"
    @post_title = "post 1 | revision 1"
    Factory(:posts_revision, :title => @post_title, :url => @post_path)
    ActionController::Base.perform_caching = true
    clear_cache
  end

  after do
    ActionController::Base.perform_caching = false
    clear_cache
  end
  
  it "verify unpublished posts are not public" do
    visit root_path
    Factory(:unpublished_post)
    page.should_not have_content("unpublished")
    visit "/monologue/unpublished"
    page.should have_content("You may have mistyped the address or the page may have moved")
  end
  
  it "admin users should be able to see the preview" do
    log_in
    visit @post_path
    page.should_not have_content("You may have mistyped the address or the page may have moved")
  end
  
  it "should not cache pages for admin" do
    log_in
    visit @post_path
    @post_path.is_page_cached?.should be_false
  end

  context "admin section" do
    it "clicks preview link" do
      log_in
      visit admin_path
      click_on @post_title
      click_on "Preview"
      current_path.should == @post_path
    end
  end
end