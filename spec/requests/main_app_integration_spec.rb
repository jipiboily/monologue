require 'spec_helper'
describe "main_app_integration" do
  before(:each) do
    clear_cache
  end

  it "should use main_app layout" do
    # TODO: make a test that can work, as it currently doesn't work at all for some reason
    
    # Monologue.layout = "layouts/application"
    # visit root_path
    # page.should have_content("dummy app layout file!")
  end
end