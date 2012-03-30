require 'spec_helper'
describe "preview" do
  before(:each) do
    @user = Factory(:user)
    @post_path = "/monologue/post/1"
    @post = Factory(:post, published: false)
    @post_title = "post 1 | revision 1"
    @post.posts_revisions.build(Factory.attributes_for(:posts_revision, user_id: @user.id, url: @post_path , title: @post_title))
    @post.save
    ActionController::Base.perform_caching = true
    clear_cache
  end

  after do
    ActionController::Base.perform_caching = false
    clear_cache
  end
  
  it "verify unpublished posts are not public" do
    visit root_path
    page.should_not have_content("post 1 | revision 1")
    lambda {
      visit post_path(@post)
    }.should raise_error(ActionController::RoutingError)
  end
  
  it "admin users should be able to see the preview" do
    lambda {
      log_in
      visit @post_path
      page.should be_success
    }.should_not raise_error(ActionController::RoutingError)
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