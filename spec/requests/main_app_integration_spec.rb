require 'spec_helper'
describe "main_app_integration" do
  before(:each) do
    clear_cache
  end
  
  it "should use main_app layout" do
    Monologue.layout = "layouts/application"
    visit root_path
    page.should have_content("dummy app layout file!")
  end
end