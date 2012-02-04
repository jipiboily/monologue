# encoding: UTF-8
require 'spec_helper'
describe "posts" do
  context "logged in user" do
    before(:each) do
      log_in
    end
    
    it "can access post's admin" do
      visit admin_posts_path
      page.should have_content "Add a monologue"
    end
    
    it "can create new post" do
      visit new_admin_post_path
      page.should have_content "New monologue"
      fill_in "Title", with: "This is a monologue"
      fill_in "Content", with: "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
      fill_in "Url", with: "/2012/this-is-a-monologue"
      fill_in "Published at", with: DateTime.now
      click_button "save"
      page.should have_content "Monologue created"
    end
    
    # it "adds a revision each time you save"
    # end
    
    it "can edit a post" do
      # TODO: remove this duplicated code. Should be a working factory
        visit new_admin_post_path
        page.should have_content "New monologue"
        fill_in "Title", with: "my title"
        fill_in "Content", with: "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
        fill_in "Url", with: "/2012/this-is-a-monologue"
        fill_in "Published at", with: DateTime.now
        click_button "save"
      # / TODO      
      visit admin_posts_path
      click_on "my title"
      page.should have_content "Edit \""
      fill_in "Title", with: "This is a new title"
      fill_in "Content", with: "New content here..."
      fill_in "Url", with: "/new-title-and-url"
      fill_in "Published at", with: DateTime.now
      click_button "save"
      page.should have_content "Monologue saved"
    end
    
    it "will output error messages if error(s) there is" do
      visit new_admin_post_path
      page.should have_content "New monologue"
      click_button "save"
      page.should have_content "Title is required"
      page.should have_content "Content is required"
      page.should have_content "Url is required"
      page.should have_content "'Published at' is required"
    end
  end
  
  context "NOT logged in user" do
    it "can NOT access post's admin" do
      visit admin_posts_path
      page.should have_content "You must first log in"
    end

    it "can NOT create new post" do
      visit new_admin_post_path
      page.should have_content "You must first log in"
    end
    
    it "can NOT edit posts" do
      pr = Factory(:posts_revision)
      visit edit_admin_post_path(pr)
      page.should have_content "You must first log in"
    end
  end  
end