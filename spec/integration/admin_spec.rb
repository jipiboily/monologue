require 'spec_helper'
describe "admin" do
  it "asks for login if there is no sessions" do
    visit admin_path
    page.should have_content("You must first log in to access admin section.")
  end
end