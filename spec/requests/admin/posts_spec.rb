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

    it "can access post's admin with pagination" do
      Factory(:post, title: "my first title")
      Factory(:post, title: "my second title")
      Monologue::Config.admin_posts_per_page = 1
      visit admin_posts_page_path page: 1
      page.should have_content "Older Posts"
    end
    
    it "can create new post" do
      visit new_admin_post_path
      page.should have_content "New monologue"
      fill_in "Title", with:  "my title"
      fill_in "Content", with:  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
      fill_in "Published at", with:  DateTime.now
      click_button "Save"
      page.should have_content "Monologue created"
    end

    it "can edit a post and then save the post" do
      Factory(:post, title: "my title")
      visit admin_posts_path
      click_on "my title"
      page.should have_content "Edit \""
      fill_in "Title", with:  "This is a new title"
      fill_in "Content", with:  "New content here..."
      fill_in "Published at", with:  DateTime.now
      click_button "Save"
      page.should have_content "Monologue saved"
    end
    
    it "will output error messages if error(s) there is" do
      visit new_admin_post_path
      page.should have_content "New monologue"
      click_button "Save"
      page.should have_content "Title is required"
      page.should have_content "Content is required"
      page.should have_content "'Published at' is required"
    end

    it "can create a new post with tags removing the empty spaces" do
      visit new_admin_post_path
      fill_in "Title", with:  "title"
      fill_in "Content", with:  "content"
      fill_in "Published at", with:  DateTime.now
      fill_in "Tags",with: "  rails, ruby,    one great tag"
      click_button "Save"
      page.should have_field :tag_list ,with: "rails, ruby, one great tag"
    end

    it "can update the tags of an edited post" do
      Factory(:post, title: "my title")
      visit admin_posts_path
      click_on "my title"
      fill_in "Tags",with: "ruby, spree"
      click_button "Save"
      page.should have_field :tag_list ,with: "ruby, spree"
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
      post = Factory(:post)
      visit edit_admin_post_path(post)
      page.should have_content "You must first log in"
    end
  end  
end