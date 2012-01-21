require 'spec_helper'
describe "posts" do
  context "logged in user" do
    before(:all) do
      log_in
    end
    
    it "can access post's admin" do
      visit admin_posts_revisions_path
      page.should have_content "Add a monologue"
    end
  end
  
  context "NOT logged in user" do
    it "can NOT access post's admin" do
      visit admin_posts_revisions_path
      page.should have_content "You must first log in"
    end

    it "can NOT create new post" do
      visit new_admin_posts_revision_path
      page.should have_content "You must first log in"
    end
    
    it "can NOT edit posts" do
      pr = Factory(:posts_revision)
      visit edit_admin_posts_revision_path(pr)
      page.should have_content "You must first log in"
    end
  end  
end