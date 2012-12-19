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

  it "should use default layout" do
    Monologue.sidebar = nil
    visit root_path

    page.status_code.should be 200
  end
end