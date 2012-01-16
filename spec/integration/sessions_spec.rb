require 'spec_helper'
describe "sessions" do
  it "can log if password provided is valid" do
    user = Factory(:user)
    visit admin_login_path
    fill_in "email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    page.should have_content("Logged in!")
  end
  
  it "won't log if bad credentials are provided" do
    user = Factory(:user)
    visit admin_login_path
    fill_in "email", with: user.email
    fill_in "Password", with: "whatever"
    click_button "Log in"
    page.should have_content("Invalid email or password")
  end

  it "can log out" do
    user = Factory(:user)
    visit admin_path
    click_link "Log out"
  end
end