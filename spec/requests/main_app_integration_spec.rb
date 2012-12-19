require 'spec_helper'
describe "main_app_integration" do
  before(:each) do
    clear_cache
  end

  it "should use main_app layout" do
    # TODO: make a working test with that. Changing layout on the fly does not seem to work.
    # Monologue.layout = "layouts/application"
    # visit root_path
    # page.should have_content("dummy app layout file!")
  end

  describe "viewing the default root_url" do
    # backup original sidebar config and restore after test
    original_sidebar_config = nil
    before(:each) do
      original_sidebar_config = Monologue.sidebar
      Monologue.sidebar = nil
    end

    after do
      Monologue.sidebar = original_sidebar_config
    end

    it "should return HTTP 200 when viewing the root url with no sidebars" do
      visit root_path

      page.status_code.should be 200
    end
  end
end