require 'spec_helper'
describe "preview" do
  before(:each) do
    url ="post/1"
    @post_path = "/monologue/#{url}"
    @post_title = "post 1 | revision 1"
    @revision = Factory(:posts_revision, title: @post_title, url: url)
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
    it "clicks preview link", :js=>true do
      log_in
      visit admin_path
      click_on @post_title
      
      wait_until(60) do
        page.should have_selector("[data-toggle='post-preview']", visible: false)
      end
      
      click_on "Preview"
      page.should have_selector("[data-toggle='post-preview']", visible: true)

      page.driver.browser.switch_to.frame "preview"
      wait_until(360) do
        page.should have_content(@post_title)
      end

    end
    
    it "Close Preview", :js=>true do
      log_in
      visit admin_path
      click_on @post_title
      
      click_on "Preview"
      page.should have_selector("[data-toggle='post-preview']", visible: true)
      link = find("[data-toggle='post-preview'] a")
      link.click
      page.should have_selector("[data-toggle='post-preview']", visible: false)
    end  
    
    it "clicking preview should not save" do
      log_in
      visit admin_path
      click_on @post_title
      new_content = "I'm modifying you but you shouldn't be saved"
      fill_in "Content", with:  new_content
      click_on "Preview"
      visit admin_path
      click_on @post_title
      page.should_not have_content(new_content)
      page.should have_content(@revision.content)
    end
    
  end
end