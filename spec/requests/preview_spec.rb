require 'spec_helper'
describe "preview" do
  before(:each) do
    url ="post/1"
    @post_path = "/monologue/#{url}"
    @post_title = "post 1"
    @post = Factory(:post, title: @post_title, url: url)
    ActionController::Base.perform_caching = true
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

      # Consistently failing with Ruby 2.0 on Travis CI -- can't find content.
      # Selenium docs indicate support for Ruby 1.8.7 to 1.9.2 https://code.google.com/p/selenium/wiki/RubyBindings
      # Comment out for now until better support for Ruby 2
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
      page.should have_content(@post.content)
    end

  end
end
